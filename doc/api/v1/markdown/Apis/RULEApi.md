# RULEApi

All URIs are relative to *https://open.cobbhub.com:8443/api/v1*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**addRule**](RULEApi.md#addRule) | **POST** /rules | Creates a new rule in the rule book.  Duplicates are not allowed |
| [**deleteFaq**](RULEApi.md#deleteFaq) | **DELETE** /rules/{id} | deletes a single rule based on the ID supplied |
| [**find rule by id**](RULEApi.md#find rule by id) | **GET** /rules/{id} | Returns a user based on a single ID, if the user does not have access to the rule |


<a name="addRule"></a>
# **addRule**
> Rule addRule(NewRule)

Creates a new rule in the rule book.  Duplicates are not allowed

    Creates a new rule in the rule book.  Duplicates are not allowed

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **NewRule** | [**NewRule**](../Models/NewRule.md)| Rule to add to the rule book | |

### Return type

[**Rule**](../Models/Rule.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

<a name="deleteFaq"></a>
# **deleteFaq**
> deleteFaq(id)

deletes a single rule based on the ID supplied

    deletes a single rule based on the ID supplied

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **id** | **Long**| ID of rule to delete | [default to null] |

### Return type

null (empty response body)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

<a name="find rule by id"></a>
# **find rule by id**
> Rule find rule by id(id)

Returns a user based on a single ID, if the user does not have access to the rule

    Returns a user based on a single ID, if the user does not have access to the rule

### Parameters

|Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **id** | **Long**| ID of rule to fetch | [default to null] |

### Return type

[**Rule**](../Models/Rule.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

