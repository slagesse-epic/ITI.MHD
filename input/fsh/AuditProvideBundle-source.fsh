Profile:        AuditProvideBundleSource
Parent:         AuditEvent
Id:             IHE.MHD.ProvideBundle.Audit.Source
Title:          "Audit Event for Provide Bundle Transaction"
Description:    "Defines constraints on the AuditEvent Resource to record when a Provide Bundle Transaction happens."
* type = http://dicom.nema.org/resources/ontology/DCM#110106 "Export"
* action = #R
* subtype = urn:ihe:event-type-code#ITI-65 "Provide Document Bundle"
// .source is already required to be populated - what agent detected the event usually one of the .agent systems sending or receiving
// .agent holds system that received, system that sent, and if known the human(s) who triggered
// .entity holds the patient identity, and the identifier of the submission
