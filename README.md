# *DaneshPark* - API

In this document we introduce ***DaneshPark*** API

## Authentication

> If you want to have good experience work with this API you should get
> your unique ***token*** through this way :

- POST `/park/public/api/authenticate`
- Request Body `{
  "email": {email}<String>,
  "password": {password}<Integer>
}`

##  Books

#### Using user Token : 
- GET`/park/public/api/get/book?token={yourtoken} `

#### All of the books : 
- GET`/park/public/api/get/books`

#### By the book id :
- GET`/park/public/api/get/bookid/{id}`

##  Chapters
- GET`/park/public/api/get/chapter/{id}?token={yourtoken}`
#### Sub Chapter :
- GET`/park/public/api/get/sub_chapter/{id}?token={yourtoken}`

##  Contents
- GET`/park/public/api/get/content/{id}?token={yourtoken}`

## Payments
- GET`/park/public/api/get/user/charge/{id}?token={yourtoken}`

## Users

#### User Register :
- POST`/park/public/api/user/new?token={yourtoken}`
- Request Body `{
  "picture": {picture}<String>,
  "firstname": {firstname}<String>,
  "lastname": {lastname}<String>",
  "father_name": {father_name}<String>,
  "national_number": {national_number}<String>,
  "birthday": {birthday}<String>,
  "gender": {gender}<String>,
  "mobile": {mobile_number}<String>,
  "phone": {phone_number}<String>,
  "address": {address}<String>,
  "email": {email}<String>,
  "password": {password}<String>,
  "reagent": {reagent}<String>,
  "role": {role}<Integer>,
  "amount": {amount}<Integer>
}`

#### User Update :
- POST`/park/public/api/update/user`
- Request Body `{
  "id": {id}<Integer>,
  "picture": {picture}<String>,
  "firstname": {firstname}<String>,
  "lastname": {lastname}<String>,
  "father_name": {father_name}<String>,
  "birthday": {birthday}<String>,
  "national_number": {national_number}<String>,
  "gender": {gender}<String>,
  "mobile": {mobile_number}<String>,
  "phone": {phone_number}<String>,
  "address": {address}<String>
}`

#### User Change Password :
- POST`/park/public/api/change/pass?token={yourtoken}`
- Request Body `{
  "password": {password}<String>
}`