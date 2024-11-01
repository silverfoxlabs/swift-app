# RecipesAPI

All URIs are relative to *https://d3jbb8n5wk0qxi.cloudfront.net*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getEmptyRecipes**](RecipesAPI.md#getemptyrecipes) | **GET** /recipes-empty.json | Retrieve empty recipes data
[**getMalformedRecipes**](RecipesAPI.md#getmalformedrecipes) | **GET** /recipes-malformed.json | Retrieve malformed recipes data
[**getRecipes**](RecipesAPI.md#getrecipes) | **GET** /recipes.json | Retrieve a list of recipes


# **getEmptyRecipes**
```swift
    open class func getEmptyRecipes(completion: @escaping (_ data: GetRecipes200Response?, _ error: Error?) -> Void)
```

Retrieve empty recipes data

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient


// Retrieve empty recipes data
RecipesAPI.getEmptyRecipes() { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**GetRecipes200Response**](GetRecipes200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMalformedRecipes**
```swift
    open class func getMalformedRecipes(completion: @escaping (_ data: GetRecipes200Response?, _ error: Error?) -> Void)
```

Retrieve malformed recipes data

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient


// Retrieve malformed recipes data
RecipesAPI.getMalformedRecipes() { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**GetRecipes200Response**](GetRecipes200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getRecipes**
```swift
    open class func getRecipes(completion: @escaping (_ data: GetRecipes200Response?, _ error: Error?) -> Void)
```

Retrieve a list of recipes

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient


// Retrieve a list of recipes
RecipesAPI.getRecipes() { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**GetRecipes200Response**](GetRecipes200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

