*** Settings ***
Library     SeleniumLibrary
Resource    /Users/samueldianpermanaputra/Projects/PythonBelajar/robotFramework/Basic/CommonKeywords.resource


*** Variables ***
${browser}      chrome
${url}          http://testautomationpractice.blogspot.com/


*** Test Cases ***
Testing Radio Buttons and Check Boxes
    Open Browser Custom    ${url}
    Maximize Browser Window
    Set Selenium Speed    1 seconds

    # 1. Handling Radio Buttons
    # Syntax: Select Radio Button    group_name    value
    Scroll Element Into View    id:country
    Select Radio Button    gender    male

    # 2. Handling Check Boxes
    # Syntax: Select Checkbox    locator
    Select Checkbox    monday
    Select Checkbox    sunday

    # 3. Unselecting Check Boxes
    Unselect Checkbox    monday

    # 4. Verifications
    Checkbox Should Be Selected    sunday
    Checkbox Should Not Be Selected    monday

    [Teardown]    Close Browser
