*** Settings ***
Library     SeleniumLibrary
Resource    /Users/samueldianpermanaputra/Projects/PythonBelajar/robotFramework/Basic/CommonKeywords.resource


*** Variables ***
${browser}          chrome
${url}              http://testautomationpractice.blogspot.com/
${Execution_Env}    False


*** Test Cases ***
Handling Dropdowns and Lists
    Open Browser Custom    ${url}    ${Execution_Env}

    # 1. Selecting from
    # Syntax: select from List by label | locator | label_name
    Scroll Element Into View    id: animals
    ${options}=    Get List Items    id:country
    Log To Console    Available options: ${options}
    Select From List By Label    country    Germany
    Select From List By Value    country    india
    Select From List By Index    country    3

    [Teardown]    Close Browser
