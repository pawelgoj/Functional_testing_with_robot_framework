from playwright.sync_api import sync_playwright, Page, BrowserContext, Playwright, Browser
import logging
from robot.api.deco import library, keyword


@library(scope='GLOBAL')
class PlaywrightSettings:
    browser: Browser = None
    context: BrowserContext = None
    page: Page = None
    p: Playwright = None

    def __init__(self):
        self.sync_playwright = sync_playwright()

    @keyword
    def launch_browser(self, browser_name: str, width: int, height: int,
                       record_video: bool = False) -> None:
        width = int(width)
        height = int(height)

        self.p = self.sync_playwright.start()
        if browser_name.lower() == 'chromium':
            self.browser = self.p.chromium.launch(headless=False)
            logging.info("Chromium browser")
        elif browser_name.lower() == 'firefox':
            self.browser = self.p.firefox.launch(headless=False)
            logging.info("Firefox browser")
        else:
            self.browser = self.p.webkit.launch(headless=False)
            logging.info("Default browser")

        if record_video:
            self.context = self.browser.new_context(
                viewport={"width": width, "height": height},
                record_video_dir="videos/",
                record_video_size={"width": 640, "height": 480},
                accept_downloads=True
            )
        else:
            self.context = self.browser.new_context(viewport={"width": width, "height": height},
                                                    accept_downloads=True)

    @keyword
    def open_web(self, url: str) -> Page:

        self.page = self.context.new_page()
        self.page.goto(url)
        if self.page.query_selector("text=No, thanks!"):
            self.page.click("text=No, thanks!")
        return self.page

    @keyword
    def close_page(self):
        self.page.close()

    @keyword
    def close_browser(self):
        self.context.close()
        self.browser.close()
        self.p.stop()

    @keyword
    def take_screenshot(self, path: str):
        return self.page.screenshot(path=path)
