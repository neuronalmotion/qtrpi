import { WebappQtRpiPage } from './app.po';

describe('webapp-qt-rpi App', function() {
  let page: WebappQtRpiPage;

  beforeEach(() => {
    page = new WebappQtRpiPage();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});
