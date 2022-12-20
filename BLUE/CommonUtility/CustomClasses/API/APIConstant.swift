import Foundation

    /// This is the Structure for API
    internal struct API {

        // MARK: - API URL

        /// Structure for URL. This will have the API end point for the server.
        struct URL {

            /// Live Server Base URL
            ///
            ///     API.URL.live
            ///
            public static let live                                  = "https://blue.testingjunction.tech/api/"

            /// Development Server Base URL - Bhikhu
            ///
            ///      API.URL.staging
            ///
            public static let staging                               = "https://blue.testingjunction.tech/api/"

            /// development Server Base URL
            ///
            ///      API.URL.development
            ///
            public static let development                           = "https://blue.testingjunction.tech/api/"
            
            
            /// development Dynamic Url Fallback  URL
            ///
            ///      API.URL.development
            ///
            public static let imageUrl                           = "https://blue.testingjunction.tech/storage/"
            

            #if DEBUG
            // Development version
            static let BASE_URL                                      = API.URL.development
            
            #elseif STAGING
            // Staging version
            static let BASE_URL                                      = API.URL.staging
            
            #elseif RELEASE
            // APPSTORE version
            static let BASE_URL                                      = API.URL.live
            
            #else
            // APPSTORE version
            static let BASE_URL                                      = API.URL.development
            
            #endif

        }

        // MARK: - Basic Response keys

        /// Structure for API Response Keys. This will use to get the data or anything based on the key from the repsonse. Do not directly use the key rather define here and use it.
        struct Response {

            static let data                                     = "data"

            static let error                                    = "error"

            static let message                                  = "message"

            static let meta                                     = "meta"

            static let extraMeta                                = "extra_meta"

            static let token                                    = "token"

            static let verificationCode                         = "verificationCode"

            static let resultData                               = "resultData"

            static let id                                       = "id"

            static let list                                     = "list"

            static let fileViewBasepath                         = "fileViewBasepath"

            static let isExist                                  = "isExist"

            static let quickBloxUser                                = "quickBloxUser"
            
            static let fileViewBasePath                                = "fileViewBasePath"
            
            static let industries                                = "industries"
            
            
            
            
        }

        struct Key {
            
            // Common
            static let emailText                                     = "emailText"
            static let first_name                                     = "first_name"
            static let last_name                                     = "last_name"
            static let phone_no                                     = "phone_no"
            static let email                                         = "email"
            static let password                                     = "password"
            static let civil_id                                     = "civil_id"
            static let fcm_token                                     = "fcm_token"
            static let nationality                                     = "nationality"
            static let age                                     = "age"
            static let language                                     = "language"
            static let experince                                     = "experince"
            static let baot_experince                                     = "baot_experince"
            static let license_number                                     = "license_number"
            static let social_id                                = "social_id"
            static let social_type                               = "social_type"
            
      
            static let old_password                                     = "old_password"
            static let new_password                                     = "new_password"
            static let confirm_password                                     = "confirm_password"
            
            //  Seafarer Boat list
            static let search                                     = "search"
            static let category                                     = "category"
            static let sub_category                                     = "sub_category"
            static let page                                     = "page"
            
            
            /// Boat Details
            static let id                                     = "id"
            
            /// Boat Gallery
            static let boat_id                                     = "boat_id"
            static let boat_booking_id                           = "boat_booking_id"
            static let rating                                 = "rating"
            static let description                      = "description"
            static let entity_id                        = "entity_id"
            /// add Boat
            ///Boattime slot
            static let startTime = "start"
            static let endTime = "end"
            ///
            static let name                                     = "name"
            static let height                                     = "height"
            static let width                                     = "width"
            static let image                                     = "image"
            static let images                                     = "images"

            static let boat_type                                     = "boat_type"
            static let str_extension                                     = "extension"
            static let str_file                                     = "file"
            
            ///product
            static let sub_category_id                                     = "sub_category_id"
            static let category_id                                     = "category_id"
            static let type                                    = "type"

        }

    }
