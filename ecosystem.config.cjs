module.exports = {
  apps: [
    {
      name: 'lottery-backend',
      script: 'server.js',
      instances: 1,
      autorestart: true,
      watch: false,
      max_memory_restart: '1G',
      error_file: './logs/pm2-backend-error.log',
      out_file: './logs/pm2-backend-out.log',
      log_date_format: 'YYYY-MM-DD HH:mm:ss Z',
      time: true,
      env: {
        NODE_ENV: 'production',
        PORT: 5001,
      },
    },
    {
      name: 'lottery-frontend',
      script: 'frontend-server.js',
      instances: 1,
      autorestart: true,
      watch: false,
      max_memory_restart: '500M',
      error_file: './logs/pm2-frontend-error.log',
      out_file: './logs/pm2-frontend-out.log',
      log_date_format: 'YYYY-MM-DD HH:mm:ss Z',
      time: true,
      env: {
        NODE_ENV: 'production',
        FRONTEND_PORT: 3005,
      },
    },
  ],
};
