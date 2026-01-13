export const updateFbPixel = () => {
  // const xFbclid = (useCookie('x-fbclid').value || '')?.toString();
  // if (!xFbclid) return;
  const FbPixelScript = document.createElement('script');
  FbPixelScript.type = 'text/javascript';
  const FbPixel = document.getElementById('FbPixel');
  if (FbPixel) {
    FbPixel.remove();
  }

  FbPixelScript.text = `
    !function(f,b,e,v,n,t,s)
    {if(f.fbq)return;n=f.fbq=function(){n.callMethod?
    n.callMethod.apply(n,arguments):n.queue.push(arguments)};
    if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
    n.queue=[];t=b.createElement(e);t.async=!0;
    t.src=v;s=b.getElementsByTagName(e)[0];
    s.parentNode.insertBefore(t,s)}(window, document,'script',
    'https://connect.facebook.net/en_US/fbevents.js');
    fbq('init', '1367512678718004');
    fbq('track', 'PageView');
  `;
  document.getElementsByTagName('head')[0].appendChild(FbPixelScript);
};
