# Documentation for Rule book for multilateral financial Instruments

<a name="documentation-for-api-endpoints"></a>
## Documentation for API Endpoints

All URIs are relative to *https://open.cobbhub.com:8443/api/v1*

| Class | Method | HTTP request | Description |
|------------ | ------------- | ------------- | -------------|
| *RULEApi* | [**addRule**](Apis/RULEApi.md#addrule) | **POST** /rules | Creates a new rule in the rule book.  Duplicates are not allowed |
*RULEApi* | [**deleteFaq**](Apis/RULEApi.md#deletefaq) | **DELETE** /rules/{id} | deletes a single rule based on the ID supplied |
*RULEApi* | [**find rule by id**](Apis/RULEApi.md#find rule by id) | **GET** /rules/{id} | Returns a user based on a single ID, if the user does not have access to the rule |
| *RuleBookApi* | [**findRules**](Apis/RuleBookApi.md#findrules) | **GET** /rules | Returns all financial Rules from the system that the user has access to |


<a name="documentation-for-models"></a>
## Documentation for Models

 - [Error](./Models/Error.md)
 - [NewRule](./Models/NewRule.md)
 - [Rule](./Models/Rule.md)
 - [Rule_allOf](./Models/Rule_allOf.md)


<a name="documentation-for-authorization"></a>
## Documentation for Authorization

All endpoints do not require authorization.
