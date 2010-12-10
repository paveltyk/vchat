$(document).ready(function(){
  $('#vchat').flash({
    src: '/vc.swf',
    width: '607px',
    height: '540px',
    flashvars: { service_url: '/chatters'}
  }, {
    expressInstall: true,
    version: '10.0.0'
  });
});
