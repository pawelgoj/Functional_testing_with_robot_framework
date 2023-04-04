from playwright.sync_api import Page
import logging
from robot.api.deco import keyword


class BookStore:
    header_loc: str = ".main-header"

    page: Page | None = None

    def init_book_store(self, page: Page) -> None:
        self.page = page

    def check_on_book_store(self, profile_url: str, page_header: str = "Book Store") -> None:
        self.page.wait_for_url(profile_url)
        text = self.page.locator(self.header_loc).text_content()

        assert text == page_header
