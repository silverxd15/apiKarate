function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  if (env == 'dev') {

  } else if (env == 'cert') {
    reqresURL = 'https://reqres.in/'
    todoURL = 'https://todo.ly/api/'
    tokenAuth = 'Basic bGVvbmFyZDRAam1ldGVyLmNvbToxMjM0NTY='
  }
  var config = {
      env: env,
      reqresURL:reqresURL,
      todoURL:todoURL,
      tokenAuth:tokenAuth
    }
  return config;
}