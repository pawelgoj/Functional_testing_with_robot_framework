from playwright.sync_api import Page
import logging
from robot.api.deco import keyword


class Profile:
    log_out_button_loc: str = ".col-md-5 > #submit"
    go_to_book_store_button_loc: str = "#gotoStore"
    delete_account_button_loc: str = ".text-center >  #submit"
    delete_all_books_button_loc: str = ".di >  #submit"
    header_profile_loc: str = ".main-header"
    cancel_button_delete_account_dialog: str = "#closeSmallModal-cancel"
    ok_button_delete_account_dialog: str = "#closeSmallModal-ok"
    dialog_header_loc: str = "#example-modal-sizes-title-sm"

    page: Page | None = None

    def init_profile(self, page: Page) -> None:
        self.page = page

    def log_out(self) -> None:
        self.page.click(self.log_out_button_loc)

    def delete_all_books(self) -> None:
        self.page.click(self.delete_all_books_button_loc)

    def delete_account(self) -> None:
        self.page.click(self.delete_account_button_loc)
        self.page.click(self.ok_button_delete_account_dialog)

        def handle_dialog(dialog):
            dialog.accept()

        self.page.on('dialog', handle_dialog)

    def try_delete_but_dismiss_dialog(self) -> None:
        self.page.click(self.delete_account_button_loc)
        self.page.click(self.cancel_button_delete_account_dialog)


    def go_to_book_store(self) -> None:
        self.page.click(self.go_to_book_store_button_loc)

    def check_logged_to_profile(self, profile_url: str, page_header: str = "Profile") -> None:
        self.page.wait_for_url(profile_url)
        text = self.page.locator(self.header_profile_loc).text_content()

        assert text == page_header
