export function jumpPath(path: string, query?: Record<string, any>) {
  const route = useRoute();
  const router = useRouter();
  sessionStorage.removeItem('vigorbuybuy-spreadsheet');
  router.push({
    path,
    query,
  });
}

export function openLink(url: string, target = '_blank') {
   const a = document.createElement('a');
    a.setAttribute('href', url);
    a.setAttribute('target', target);
    a.setAttribute('id', 'camnpr');
    document.body.appendChild(a);
    a.click();
};

/**
 * 复制
 * @param text 复制文本
 */
export async function handleCopy (text: string) {
  // 创建临时文本框
  const textarea = document.createElement('textarea');
  textarea.value = text;
  textarea.style.position = 'fixed'; // 避免滚动影响
  document.body.appendChild(textarea);
  // 选中并复制
  textarea.select();
  const success = document.execCommand('copy');
  // 清理临时元素
  document.body.removeChild(textarea);
  ElMessage({
    message: 'Copied!',
    type: 'success',
    grouping: true,
    // customClass: 'base-ui-message',
    duration: 2000,
  });
};

/**
 * 清洗对象，移除/转换无法被IndexedDB序列化的属性
 * @param {any} data - 要清洗的数据（对象/数组）
 * @returns {any} 可序列化的干净数据
 */
function cleanIndexedDBData(data:any) {
  // 处理基本类型
  if (data === null || typeof data !== 'object') {
    // 排除undefined，转为null
    return data === undefined ? null : data;
  }

  // 处理数组
  if (Array.isArray(data)) {
    return data.map(item => cleanIndexedDBData(item));
  }

  // 处理普通对象（排除DOM节点、函数等）
  if (Object.prototype.toString.call(data) === '[object Object]') {
    const cleanObj = {};
    for (const [key, value] of Object.entries(data)) {
      // 跳过函数、Symbol属性
      if (typeof value === 'function' || typeof key === 'symbol' || typeof value === 'symbol') {
        continue;
      }
      // 递归清洗属性值
      cleanObj[key] = cleanIndexedDBData(value);
    }
    return cleanObj;
  }

  // 处理特殊对象（转为字符串）
  if (data instanceof Date) {
    return data.toISOString(); // 日期转字符串
  }
  if (data instanceof RegExp) {
    return data.toString(); // 正则转字符串
  }
  if (data instanceof Map) {
    return Object.fromEntries(data); // Map转普通对象
  }
  if (data instanceof Set) {
    return Array.from(data); // Set转数组
  }

  // 其他无法处理的类型，转为字符串
  return String(data);
}

/**
 * 打开IndexedDB数据库
 * @param {string} dbName - 数据库名
 * @param {string} storeName - 对象仓库名（表名）
 * @param {number} version - 数据库版本号
 * @returns {Promise<IDBDatabase>} 数据库实例
 */
function openDB(dbName:string, storeName:string, version = 1) {
  return new Promise((resolve, reject) => {
    const request = indexedDB.open(dbName, version);

    // 数据库初始化/版本更新时创建表
    request.onupgradeneeded = (e) => {
      const db = e.target.result;
      if (!db.objectStoreNames.contains(storeName)) {
        // 假设主键为id（根据你的实际表结构调整）
        db.createObjectStore(storeName, { keyPath: "id" });
      }
    };

    request.onsuccess = (e) => resolve(e.target.result);
    request.onerror = (e) => reject(e.target.error);
  });
}

/**
 * 2. 初始化IndexedDB并写入JSON数据
 * @param {string} dbName - 数据库名称
 * @param {string} storeName - 对象仓库（表）名称
 * @param {Array} data - 要写入的JSON数组数据
 * @returns {Promise} - 操作结果Promise
 */
export function initDBAndWriteData(dbName:string, storeName:string, data:any[]) {
  return new Promise((resolve, reject) => {
    // 打开/创建数据库（版本号1）
    const request = indexedDB.open(dbName, 1);
    let cleanData = cleanIndexedDBData(data);

    // 数据库首次创建/版本更新时执行（创建表结构）
    request.onupgradeneeded = function (event) {
      const db = event?.target?.result;
      // 判断表是否存在，不存在则创建（主键设为id，保证唯一性）
      if (!db.objectStoreNames.contains(storeName)) {
        db.createObjectStore(storeName); // keyPath指定主键字段
      }
    };

    // 数据库打开成功
    request.onsuccess = function (event) {
      const db = event?.target?.result;
      // 创建事务（readwrite表示可读写）
      const transaction = db.transaction(storeName, "readwrite");
      const store = transaction.objectStore(storeName);

      // 批量写入JSON数据
      cleanData.forEach(item => {
        // put：存在则更新，不存在则新增；add：存在则报错
        store.put(item); 
      });

      // 事务完成（所有数据写入成功）
      transaction.oncomplete = function () {
        // console.log(`✅ JSON数据已成功写入IndexedDB的${storeName}表`);
        db.close(); // 关闭数据库连接
        resolve(true);
      };

      // 事务失败
      transaction.onerror = function (error:any ) {
        console.error("❌ 数据写入失败：", error.target.error);
        reject(error.target.error);
      };
    };

    // 数据库打开失败
    request.onerror = function (error:any) {
      console.error("❌ 数据库连接失败：", error.target.error);
      reject(error.target.error);
    };
  });
}

/**
 * 3. 从IndexedDB查询数据（验证写入结果）
 * @param {string} dbName - 数据库名称
 * @param {string} storeName - 对象仓库名称
 * @returns {Promise<Array>} - 查询到的数据
 */
export function queryDataFromDB(dbName:string, storeName:string) {
  return new Promise((resolve, reject) => {
    const request = indexedDB.open(dbName, 1);

    request.onsuccess = function (event) {
      const db = event?.target?.result;
      const transaction = db.transaction(storeName, "readonly"); // 只读事务
      const store = transaction.objectStore(storeName);
      const queryRequest = store.getAll(); // 查询所有数据

      queryRequest.onsuccess = function () {
        // console.log(`📋 从${storeName}表查询到的数据：`, queryRequest.result);
        db.close();
        resolve(queryRequest.result);
      };

      queryRequest.onerror = function (error:string) {
        console.error("❌ 查询数据失败：", error.target.error);
        reject(error?.target?.error);
      };
    };

    request.onerror = function (error:string) {
      reject(error?.target?.error);
    };
  });
}

/**
 * 清空整个表的所有数据
 * @param {string} dbName - 数据库名
 * @param {string} storeName - 表名
 * @returns {Promise<boolean>} 清空是否成功
 */
export async function clearStoreData(dbName:string, storeName:string) {
  try {
    const db = await openDB(dbName, storeName);
    const transaction = db.transaction(storeName, "readwrite");
    const store = transaction.objectStore(storeName);

    // 执行清空操作
    const clearRequest = store.clear();

    return new Promise((resolve, reject) => {
      clearRequest.onsuccess = () => {
        console.log(`✅ ${storeName}表数据已全部清空`);
        db.close();
        resolve(true);
      };

      clearRequest.onerror = (e) => {
        console.error(`❌ 清空失败：`, e.target.error);
        db.close();
        reject(false);
      };
    });
  } catch (error) {
    console.error("数据库连接失败：", error);
    return false;
  }
}

/**
 * 根据主键查询单条数据
 * @param {string} dbName - 数据库名
 * @param {string} storeName - 表名
 * @param {number|string} primaryKey - 主键值（如id=1）
 * @returns {Promise<Object|null>} 查询到的数据（无则返回null）
 */
export async function queryDataByKey(dbName:string, storeName:string, primaryKey:number) {
  try {
    const db = await openDB(dbName, storeName);
    // 查询操作使用readonly事务（性能更好）
    const transaction = db.transaction(storeName, "readonly");
    const store = transaction.objectStore(storeName);

    // 核心API：get(主键值)
    const queryRequest = store.get(primaryKey);

    return new Promise((resolve, reject) => {
      queryRequest.onsuccess = () => {
        const data = queryRequest.result;
        console.log(`✅ 主键${primaryKey}查询结果：`, data);
        db.close();
        resolve(data); // 无数据时返回null
      };

      queryRequest.onerror = (e) => {
        console.error(`❌ 查询失败：`, e.target.error);
        db.close();
        reject(null);
      };
    });
  } catch (error) {
    console.error("数据库连接失败：", error);
    return null;
  }
}
