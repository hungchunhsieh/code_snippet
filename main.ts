import { bootstrapApplication } from '@angular/platform-browser';
import { appConfig } from './app/app.config';
import { AppComponent } from './app/app.component';
import { setupWorker } from 'msw/browser';
import { handlers } from './mocks/handlers';

const worker = setupWorker(...handlers);

worker
  .start({
    serviceWorker: {
      url: '/assets/mockServiceWorker.js',
    },
  })
  .then(() => {
    console.log('MSW Mock Service Worker started');
    return bootstrapApplication(AppComponent, appConfig);
  })
  .catch((err) => {
    console.error('MSW 或應用初始化失敗', err);
  });
