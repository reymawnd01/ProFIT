import { LightningElement, api } from "lwc";
import getSpeakers from "@salesforce/apex/EventDetailsController.getSpeakers";
import getLocationDetails from "@salesforce/apex/EventDetailsController.getLocationDetails";
import getAttendees from "@salesforce/apex/EventDetailsController.getAttendees";

//COLUMN PROPERTIES FOR SPEAKER
const columns = [
  { label: "Name", fieldName: "Name"},
  { label: "Email", fieldName: "Email", type: "email" },
  { label: "Phone", fieldName: "Phone", type: "phone" },
  { label: "Company Name", fieldName: "CompanyName", type: "company"}
];

//COLUMN PROPERTIES FOR ATTENDEE
const columnsAtt = [
  { label: "Name", fieldName: "Name"},
  { label: "Email", fieldName: "Email", type: "email" },
  { label: "Company Name", fieldName: "CompanyName", type: "company"},
  { label: "Location", fieldName: "Location"}
];

export default class EventDetails extends LightningElement {
  @api recordId;
  speakerList;
  eventRec;
  attendeesList;
  errors;
  columnsList = columns;
  columnAttendee = columnsAtt;

  //ONACTIVE ON SPEAKER TAB THIS METHOD WILL EXECUTE
  handleSpeakerActive() {
    getSpeakers({
      eventId: this.recordId
    })
      .then((result) => {
        result.forEach(speaker => {
          speaker.Name = speaker.Speaker__r.Name,
          speaker.Email = speaker.Speaker__r.Email__c,
          speaker.Phone = speaker.Speaker__r.Phone__c,
          speaker.CompanyName = speaker.Speaker__r.Company__c
        });
        this.speakerList = result;
        this.errors = undefined;
  }).catch((err) => {
    this.errors = err;
    this.speakerList = undefined;
  });
}

 //ONACTIVE ON LOCATION TAB THIS METHOD WILL EXECUTE
   handleLocationDetails() {
    getLocationDetails({
      eventId: this.recordId
    })
      .then((result) => {
        if (result.Location__c) {
          this.eventRec = result;
        } else {
          this.eventRec = undefined;
        }
        this.errors = undefined;
      })
      .catch((err) => {
        this.errors = err;
        this.speakerList = undefined;
      });
  } 

   //ONCLICK ON ATTENDEE TAB THIS METHOD WILL HAPPEN
  handleEventAttendee() {
    getAttendees({
      eventId: this.recordId
    })
      .then((result) => {
        result.forEach((attendee) => {
          attendee.Name = attendee.Attendee__r.Name;
          attendee.Email = attendee.Attendee__r.Email__c;
          attendee.CompanyName = attendee.Attendee__r.Company_Name__c;
          if (attendee.Attendee__r.Location__c) {
            attendee.Location = attendee.Attendee__r.Location__r.Name;
          } else {
            attendee.Location = "N/A";
          }
        });
        this.attendeesList = result;
        this.errors = undefined;
      })
      .catch((err) => {
        this.errors = err;
        this.speakerList = undefined;
      });
  }
}
