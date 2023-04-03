
*** Settings ***
Documentation   Tesing of form componennt
Library         Browser
Library         RPA.FileSystem
Library         BuiltIn


*** Variables ***
| #LOCATORS FORM               |
| ${Student_Name}              |  //td[.='Student Name']/following-sibling::td
| ${Student_Email}             |  //td[.='Student Email']/following-sibling::td
| ${Gender_F_LOCATOR}          |  //td[.='Gender']/following-sibling::td
| ${Mobile_F_LOCATOR}          |  //td[.='Mobile']/following-sibling::td
| ${Date_of_Birth_F_LOCATOR}   |  //td[.='Date of Birth']/following-sibling::td
| ${Subjects_F_LOCATOR}        |  //td[.='Subjects']/following-sibling::td
| ${Hobbies_F_LOCATOR}         |  //td[.='Hobbies']/following-sibling::td
| ${Picture_F_LOCATOR}         |  //td[.='Picture']/following-sibling::td
| ${Address_F_LOCATOR}         |  //td[.='Address']/following-sibling::td
| ${State_and_City_F_LOCATOR}  |  //td[.='State and City']/following-sibling::td
| ${BUTTON_CLOSE_CHECK-TABLE}  |  \#closeLargeModal
| ${summary_table}             |  .modal-dialog.modal-lg


*** Keywords ***
Check data in summary
    [Arguments]                ${NAME}=Test
    ...                        ${LAST_NAME}=Test
    ...                        ${EMAIL}=test@test.com
    ...                        ${GENDER}=male     # or famale or other
    ...                        ${PHONE}=48501234567
    ...                        ${PICTURE_PATH}=img.png
    ...                        ${Address}=ul. Cos 45/9 Drno
    ...                        ${CITY}=None
    ...                        ${STATE}=None
    ...                        ${SUBJECTS}=None
    ...                        ${HOBBIES}=None
    ...                        ${day_of_month}=26
    ...                        ${year}=1990
    ...                        ${month}=May

    [Documentation]           Check that the summary has the correct data

    # Replace \n with space, the ${SPACE} is not user definet variable is special buid in variable
    # Represents space
    ${Address}=               Replace String  ${Address}  \n  ${SPACE}

    ${Name_surname}=          Catenate  ${NAME}  ${LAST_NAME}
    Get Text                  ${Student_Name}  ==  ${Name_surname}
    Get Text                  ${Student_Email}  ==  ${EMAIL}
    ${Gender_TC}=             Convert To Title Case  ${Gender}
    Get Text                  ${Gender_F_LOCATOR}  ==  ${Gender_TC}
    Get Text                  ${Mobile_F_LOCATOR}  ==  ${PHONE}

    ${Date_of_Birth}=         Catenate  ${day_of_month}  ${month}
    ${Date_of_Birth}=         Catenate  SEPARATOR=,  ${Date_of_Birth}  ${year}
    Get Text                  ${Date_of_Birth_F_LOCATOR}  ==  ${Date_of_Birth}

    ${Subjects_in_form}=      Get Text    ${Subjects_F_LOCATOR}
    @{SUBJECTS}=              Split String  ${SUBJECTS}[0]

    FOR  ${SUBJECT}  IN  @{SUBJECTS}
        Should Contain        ${Subjects_in_form}  ${SUBJECT}
    END

    ${Hobbies_in_form}=       Get Text    ${Hobbies_F_LOCATOR}
    @{HOBBIES}=               Split String  ${HOBBIES}[0]

    FOR  ${HOBBY}  IN  @{HOBBIES}
        Should Contain        ${Hobbies_in_form}  ${HOBBY}
    END

    Get Text                  ${Picture_F_LOCATOR}  ==  ${Picture}
    Get Text                  ${Address_F_LOCATOR}  ==  ${Address}
    ${State_and_City}=        Get Text    ${State_and_City_F_LOCATOR}
    Should Contain            ${State_and_City}  ${CITY}
    Should Contain            ${State_and_City}  ${STATE}
    Take Screenshot

Check sumarry is not show
    Get Element Count         ${summary_table}  ==  0
