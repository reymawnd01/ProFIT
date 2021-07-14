public with sharing class LocationCheckerHandler {
    
        @future (callout=true)
        public static void zipCodeCallOut(String locId) {
            Location__c loc = [Select Id, Zip_Verified__c, State__c, Street__c, Postal_Code__c, City__c from Location__c where Id = :locId];
    
            Http httpzip = new Http();
            HttpRequest reqzip = new HttpRequest();
            String addzip = 'https://us-zipcode.api.smartystreets.com/lookup?auth-id=3c0bd7a6-fe44-df86-a3ab-b97a28365ab9&auth-token=g9cavqbjBDb9OiUKSrn5&city=&state=&zipcode=' +loc.Postal_Code__c;
            reqzip.setEndPoint(addzip);
            reqzip.setMethod('GET');
            HttpResponse respzip= new HttpResponse();
            respzip = httpzip.send(reqzip);
            System.debug(respzip.getStatusCode());
            System.debug(loc.Postal_Code__c);
    
            try {
                if(respzip.getStatusCode() == 200){
                    List<Object> resultsZipList = (List<Object>)JSON.deserializeUntyped(respzip.getBody());
                        for(Object obj : resultsZipList){
                            Map<String, Object> results = (Map<String, Object>) obj;
                            List<Object> zipObject = (List<Object>) results.get('zipcodes');
                            if(zipObject!=null){
                                locationCall(locId);
                            }
                        }
                    
                    }
            } 
            
            catch (Exception ex) {
                System.debug('Exception -- ' + ex.getMessage());
            }
        }
        
        public static void locationCall(String locId){
            Location__c loc = [Select Id,Zip_Verified__c,State__c,Street__c,Postal_Code__c,City__c from Location__c where Id = :locId];
            Http httpst = new Http();
            HttpRequest reqst = new HttpRequest();
             String addst = 'https://us-street.api.smartystreets.com/street-address?auth-id=3c0bd7a6-fe44-df86-a3ab-b97a28365ab9&auth-token=g9cavqbjBDb9OiUKSrn5&'
             +'street=' + EncodingUtil.urlEncode(loc.Street__c, 'UTF-8') 
             +'&city='+ EncodingUtil.urlEncode(loc.City__c, 'UTF-8')
             +'&state='+EncodingUtil.urlEncode(loc.State__c, 'UTF-8');
             reqst.setEndPoint(addst);
             reqst.setMethod('GET');
            HttpResponse respst= new HttpResponse();
            respst = httpst.send(reqst); 
            try {
                if(respst.getStatusCode() == 200){
                    String respstBody = respst.getBody();
                        if(respstBody.length()>2){
                            loc.Zip_Verified__c = true;
                            loc.Verified__c = true;
                        }else{
                            loc.Zip_Verified__c = false;
                            loc.Verified__c = false;
                        }
                        update loc;
                }
            } 
            catch (Exception ex) {
                System.debug('Exception -- ' + ex.getMessage());
            }
        }
    
    }