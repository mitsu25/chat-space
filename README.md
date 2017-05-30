 == README

 This README would normally document whatever steps are necessary to get the
 application up and running.

 Things you may want to cover:

 * Ruby version

 * System dependencies

  * Configuration

  * Database creation

# DB設計

##  users table
|Column   |Type   |Options                          |
|:--------|:-----:|:--------------------------------|
|id       |integer|index:true,null:false            |
|name     |string |index:true,null:false,unique:true|
|email    |string |null:false                       |
|password |string |null:false                       |

###  Association

+ has_many :groups, through: members
+ has_many :messages
+ has_many :members

##  groups table
|Column|Type  |Options                              |
|:-----|:-----:|:-----------------------------------|
|id    |integer|null:false                          |
|name  |string |null:false                          |

###  Association

+ has_many :users, through: members
+ has_many :members

##  members table
|Column  |Type      |Options                         |
|:-------|:--------:|:-------------------------------|
|id      |integer   |null:false                      |
|user_id |references|foreign_key: true               |
|group_id|references|foreign_key: true               |

###  Association

+ belongs_to :user
+ belongs_to :groups

##  messages table
|Column |Type      |Options                     |
|:------|:--------:|:---------------------------|
|body   |text      |null:false                  |
|user   |references|index:true,foreign_key: true|
|group  |references|index:true,foreign_key: true|

###  Association

+ belongs_to :user
+ belongs_to :groups


* Database initialization

 * How to run the test suite

 * Services (job queues, cache servers, search engines, etc.)

 * Deployment instructions

 * ...


 Please feel free to use a different markup language if you do not plan to run
 <tt>rake doc:app</tt>.
