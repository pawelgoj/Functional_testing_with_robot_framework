
*** Settings ***
Documentation   Testing student registration form
Library         Browser
Library         RPA.FileSystem
Test Setup      New Browser  browser=chromium  headless=False  timeout=60
Test Teardown   Close Browser    CURRENT
Suite Teardown  Log  'Done!'

| *** Variables ***         |  Locator
| ${NAME_LOCATOR}           |  \#firstName
| ${LAST_NAME}              |  \#lastName
| ${EMAIL}                  |  \#userEmail
| ${RADIO_INPUT_MALE}       |  [for='gender-radio-1']
| ${RADIO_INPUT_FAMALE}     |  [for='gender-radio-2']
| ${RADIO_INPUT_OTHER}      |  [for='gender-radio-3']
| ${PHONE}                  |  \#userNumber
| ${DATE_OF_BIRTH}          |  \#dateOfBirthInput
| #CALENDAR                 |
| ${MONTH}                  |  .react-datepicker__month-select
| ${YEAR}                   |  .react-datepicker__year-select
| ${DAY}                    |  .react-datepicker__day react-datepicker__day--026
| ${PREVIOUS_MONTH}         |  .react-datepicker__navigation--previous
| ${NEXT_MONTH}             |  .react-datepicker__navigation--next
| ${SUBJECT}                |  .subjects-auto-complete__value-container
| ${MATHS}                  |  "Maths"
| ${HOBBIES_SPORT}          |  [for='hobbies-checkbox-1']
| ${HOBBIES_READING}        |  [for='hobbies-checkbox-2']
| ${HOBBIES_MUSIC}          |  [for='hobbies-checkbox-3']
| ${UPLOAD_PICTURE}         |  \#uploadPicture
| ${CURRENT_ADDRESS}        |  \#currentAddress
| ${STATE}                  |  \#state
| #STATE                    |
| ${STATE_TO_CHOSE}         |  \#react-select-3-option-2
| ${CITY}                   |  \#city
| #CITY CHOSE               |
| ${CITY_TO_CHOSE}          |  \#city > .css-yk16xz-control
| ${SUBMIT_BUTTON}          |  \#submit


*** test cases ***
Fill form positive test case
    [Documentation]            It is fill form positive test case
    New Context                viewport={'width': 1920, 'height': 1080}  tracing=trace.zip
    New Page                   https://demoqa.com/automation-practice-form
    Fill Text                  ${NAME_LOCATOR}  username
    Fill Text                  ${LAST_NAME}  usersurname
    Fill Text                  ${EMAIL}  user@mail.com
    Click                      ${RADIO_INPUT_MALE}  left
    Fill Text                  ${PHONE}  111111111
    Click                      ${SUBJECT}  left
    Keyboard Input             insertText  m
    Click                      ${MATHS}  left
    Click                      ${HOBBIES_SPORT}  left
    Upload File By Selector    ${UPLOAD_PICTURE}  .\\test_data\\img.png
    Fill Text                  ${CURRENT_ADDRESS}   ul. Cos 45/9 \n Drno
    Click                      ${SUBMIT_BUTTON}  left



