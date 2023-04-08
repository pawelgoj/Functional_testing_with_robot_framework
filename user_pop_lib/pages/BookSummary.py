from playwright.sync_api import Page


class BookSummary:

    title_loc: str = "#title-wrapper #userName-value"
    page: Page | None = None

    def init_book_summary(self, page: Page) -> None:
        self.page = page

    def check_book_title_in_summary(self, title: str) -> None:
        self.page.get_by_text(title).is_visible(timeout=1000)
