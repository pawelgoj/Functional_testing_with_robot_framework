from playwright.sync_api import Page
import logging
from robot.api.deco import keyword


class Login:
    username_loc: str = "#userName"
    password_loc: str = "#password"
    button_login_loc: str = "#login"
    button_new_user_loc: str = "#newUser"
    text_info_loc: str = "#name"
    header_loc: str = ".main-header"

    page: Page | None = None

    @keyword('Init login page')
    def init_login_page(self, page: Page):
        self.page = page

    @keyword
    def fill_user_name_field(self, name: str) -> None:
        self.page.click(self.username_loc)
        self.page.type(self.username_loc, name)

    @keyword
    def check_message_to_user(self, text: str):
        text_in_web_element = self.page.text_content(self.text_info_loc)
        logging.info(f"Text on web: {text_in_web_element}")
        assert text_in_web_element == text

    @keyword
    def fill_user_password(self, password: str) -> None:
        self.page.click(self.password_loc)
        self.page.type(self.password_loc, password)

    @keyword
    def click_login_button(self) -> None:
        self.page.click(self.button_login_loc)

    @keyword
    def click_new_user_button(self) -> None:
        self.page.click(self.button_new_user_loc)

    def check_on_login_page(self, login_url: str, page_header: str = "Login") -> None:
        self.page.wait_for_url(login_url)
        text = self.page.locator(".main-header").text_content()

        assert text == page_header


