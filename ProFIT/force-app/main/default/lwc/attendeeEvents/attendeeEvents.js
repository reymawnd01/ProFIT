import { LightningElement, api, track } from 'lwc';
import eventRecord from '@salesforce/apex/EventUpcomingEvents.eventRecord';
import eventPastRecord from '@salesforce/apex/EventUpcomingEvents.eventPastRecord';
// BLUEPRINT

const columns = [
    {
      // Name of Event
      label: "Event Name",
      fieldName: "detailsPage",
      type: "url",
      wrapText: "true",
      typeAttributes: {
        label: {
          fieldName: "Name"
        }
      }
    },
    {
      // Name of Organizer
      label: " Event Organizer",
      fieldName: "evtOrganizer",
      cellAttributes: {
        iconName: "standard:user"
      }
    },
    {
      // Date of Event
      label: "Event Date and Time",
      fieldName: "StartDateTime",
      type: "date",
      typeAttributes: {
        year: "numeric",
        month: "long",
        day: "2-digit",
      }
    },
    {
      label: "Location",
      fieldName: "Location",
      type: "text",
      cellAttributes: {
        iconName: "utility:location"
      }
    }
  ];

export default class AttendeeEvents extends LightningElement {
    @api recordId;
    @track events;
    @track pastevents;
    errors;
    columnsList = columns;
    columsListPast = columns;

      handleUpcomingEvent() {
        eventRecord({
          attendeeId: this.recordId
        })
          .then((result) => {
            //window.console.log(" error ", result);
            result.forEach((record) => {
              record.Name = record.Event__r.Name__c;
              record.detailsPage =
                "https://" + window.location.host + "/" + record.Event__c;
              record.evtOrganizer = record.Event__r.Organizer__r.Name;
              record.StartDateTime = record.Event__r.Start__c;
              if (record.Event__r.Location__c) {
                record.Location = record.Event__r.Location__r.Name;
              } else {
                record.Location = "This is a virtual event";
              }
            });
            this.events = result;
            //window.console.log(" result ", result);
            this.errors = undefined;
          })
          .catch((error) => {
            this.events = undefined;
            this.errors = JSON.stringify(error);
          });
      }
      handlePastEvent(){
        eventPastRecord({
          attendeeId: this.recordId
        })
          .then((result) => {
            //window.console.log(" error ", result);
            result.forEach((record) => {
              record.Name = record.Event__r.Name__c;
              record.detailsPage =
                "https://" + window.location.host + "/" + record.Event__c;
              record.evtOrganizer = record.Event__r.Organizer__r.Name;
              record.StartDateTime = record.Event__r.Start__c;
              if (record.Event__r.Location__c) {
                record.Location = record.Event__r.Location__r.Name;
              } else {
                record.Location = "This is a virtual event";
              }
            });
            this.pastevents = result;
            //window.console.log(" result ", result);
            this.errors = undefined;
          })
          .catch((error) => {
            this.pastevents = undefined;
            this.errors = JSON.stringify(error);
          });
      }
    
}