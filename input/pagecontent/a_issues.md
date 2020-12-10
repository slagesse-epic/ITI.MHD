### Issues

#### Open Issues

* MHD_039: How important are Folders? We could support Document Source  Document Recipient ability to create and update Folders. To support Document Consumer  Document Responder support of folders would require adding another Transaction for Find Folders, or some other method that the Document Consumer obtains knowledge of the Folder (such as through _include). Are folders really important today, or have they been replaced by the ReferenceIdList?
* MHD_044: There is more detail in an XDS error on Provide and Register Document Set-b that is not obvious how to translate into the FHIR response [ITI-65]. Suggestions welcome.
* MHD_051: More of the [ITI-18] queries could be utilized with the addition of the identifier FHIR parameter, however this would then present combinations of query parameters at the MHD (FHIR) API that are not simple transforms to [ITI-18] queries. For example, a Document Consumer provides both identifier query parameter, and another query parameter. At this time, MHD is focused on the most likely queries that a ‘mobile’ client would need, and these are satisfied with FindDocuments and FindSubmissionSets alone. Trial Implementation experience should be provided to IHE ITI Technical Committee in view of the need for other query parameters. Additional query parameters are allowed by MHD, they are simply not required of servers to do anything other than ignore the additional query parameters.
* MHD_052: Need an element in List to hold contentCodeList element from XDS. Previous versions of MHD put this into the .code element. However, the .code element is 0..1, and intended to identify the kind of List. See GF#19822 requested for R5.
* CP-ITI-1100: Need a way to find DocumentReference that hold attachments with a specified creation date/time. For the time during FHIR R4, we have guided the implementer to use the .date element to hold the created date/time. This solution requires careful duplication of the date value in both date and the attachment. This duplication enables use of the elements and query against date. The .date element in FHIR is defined as when the DocumentReference was created, which might be later than the document creation date/time. GF#19823 requested query parameter for the attachment created date/time for R5
* MHD_053: Note that there is an emerging issue that FHIR has not addressed and that is how distributed systems behave, and how Patient links affect recorded data. Thus, it is difficult to determine today that the response Bundle content all will be pointing at the exact same Patient, although they should all be referring to the same human.
* CP-ITI-1116: Dissonance between FHIR concept of Transaction, and XDS Provide and Register transaction. This is partially addressed in CP-ITI-1095 regarding PartialFolderContentNotProcessed. In that a Document Responder is allowed to fail the full transaction according to FHIR transaction rules but is also allowed to soft warn. The soft warn would most likely be needed when implementing XDS-on-FHIR, as the XDS actors will have returned warnings. Thus, the Document Recipient must be allowed to return these soft warnings. In this case the MHD Document Recipient can’t undo the XDS transaction, so it must be allowed to return success with warnings.

#### Closed Issues

* Resolved in MHD Revision 3.0
* MHD_054: Request to add the identifier query parameter to DocumentReference and DocumentManifest. 
* MHD_043: We neither mandate or forbid the [ITI-68] from acting as a FHIR Binary endpoint. It would return a FHIR Binary resource with the content contained if the Accept headers ask for FHIR types, depending on the server capability.
* MHD_042: MHD does not declare options for the various associations (replaces, transforms, appends), but rather provides the capability to all. However, the Document Responder in XDS-on-FHIR Option must support all of these association types. It may still get a failure from the Registry that it must pass back to the Document Source.
* MHD_047: The tag used to indicate the Provide transaction must change. The encoding rules don't allow for "-" character. We could just change ITI-65 into ITI_65, but a breaking change is a breaking change. So, we have replaced with an actual structure definition based in the same URI space as our other Structure definitions. This means that we would no-longer use http://ihe.net/fhir/tag/iti-65, but rather we would use http://ihe.net/fhir/StructureDefinition/IHE_MHD_Provide_Comprehensive_DocumentBundle, or http://ihe.net/fhir/StructureDefinition/IHE_MHD_Provide_Minimal_DocumentBundle"MHD_048: We have chosen to define some secondary resources as ‘contained’, which in FHIR means that they would not standalone, and thus would not be revisable. We chose this characteristic as the closest to XDS metadata principle. However, this means that these secondary resources would not be searchable.
* CP-ITI-1119: Made clear that Document Source must not populate any entryUUID.
* CP-ITI-1115: Added requirement for location on the Bundle response and indicate etag is required if the server supports versioning (which the profile does not require). Also added GF#19824 to request this be clarified in FHIR in R5.
* CP-ITI-1126: added clarification that the transaction status is 200, and that each entry is 201 with location must be populated.
* CP-ITI-1114: clarify that in a Provide transaction all of the DocumentReference, DocumentManifest, and List resources must point at the same Patient resource. Added clarity to query transactions that when Patient parameter is used that both actors must have access to that Patient resource. Also added cautions to the security considerations.
* CP-ITI-1113: Added additional clarification of Reference url compliance vs .attachment.url compliance. Where attachment.url is a datatype “URL” it can carry a value that is compliant with Reference but can also carry any valid URL.
* CP-ITI-1102: Addressed bugs in the volume 3 table.
* CP-ITI-1101: This CP requests specifics on what is expected of a Document Responder implementing the Comprehensive Option. This is already handled in the more correct location in Volume 2 on the expected actions for the Document Responder. See Section 3.65.4.1.3.
* CP-ITI-1095: It is observed that in FHIR a transaction must succeed or fail. Thus, the inclusion of a Folder that the Document Recipient can’t process should result in failure of the whole transaction. The text of MHD has aligned with the text of XDS ITI TF-2b:3.41.4.1.3.1 that allows a soft failure on Folders that are not supported. Should MHD take this softer position or stick with normal FHIR transaction behavior. For those systems based on a FHIR system they would likely prefer sticking with the FHIR definition, but those are likely also to easily support Folder (List Resource). Those that are a frontend to an XDS (XDS-on-FHIR) are more likely to prefer the softer approach, as they are going to need to pass through PartialFolderContentNotProcessed. Thus, the MHD Profile has been updated to indicate that either a full transaction failure or soft failure shall happen. 
* CP-ITI-1089: Added emphasis on the response to the query transactions are compliant resources to the FHIR specification and will likely be compliant with MHD. There was already emphasis for the Document Consumer to be robust when processing the Bundle. There were questions of needing to address an operational environment with mismatched minimal vs comprehensive, this seems well enough explained and unclear what further wording would help with this clarity.
* MHD_049: ProviderRole has been added to FHIR STU3, and now added to DocumentReference and DocumentManifest. A FHIR CR 13266 resolved this. 
* MHD_050: Using FHIR List as a Folder is minimally supported. Have defined a constant List.code that identifies those List resources that are Document Sharing Folders. 
* MHD_036: There is a missing capability to fully represent XDS author in FHIR. This because FHIR DocumentReference and DocumentManifest only support ‘author’, not the other roles that could be supported in XDS. This author element precoordinates that the value is only the author. GF#13266: DocumentReference and DocumentManifest author element needs to be more like Provenance.agent  Current FHIR core uses PractitionerRole and has wider support for author types.
* MHD_038: Issue with how to carry CDA®  root plus extension. We have documented current solution in Appendix Z– How to represent root+extension in a FHIR Identifier. However, FHIR should be more normative, so we have opened a CR http://gforge.hl7.org/gf/project/fhir/tracker/?action=TrackerItemEdit&tracker_item_id=13223 FHIR core has decided upon the root, and root+extension as we have defined it in Appendix Z.
* Resolved in MHD revision 2.4
* MHD_040: Find Document References does not support the GetRelatedDocuments stored query in the same way, but the queries provided can provide the same functionality.
* MHD_041: There is now a declared option to indicate a system that requires minimal metadata support. Therefore, a Document Source that uses minimal metadata may receive an error from a Document Recipient that does not support minimal metadata.
* MHD_037: STU3 now the Reference datatype can carry a URL to a Resource, or an Identifier of what could be a resource. We chose to specify use of URI and are silent on identifier until a compelling use case or issue appears.
* MHD_045: MHD scope is as a front API. Thus, it intends to be standalone, or as a front API to XDS/XCA/XDR. It therefore does not intend to support where XDS is the frontend API with MHD as the backend. The result is that MHD query model is a subset of XDS.
* MHD_046: MHD is an Interoperability Profile and does not include systems design that would be necessary to efficiently implement. There is considerable room for creative systems design.
* MHD_001: Standards selection is now FHIR DSTU2. The profile restricts FHIR use to that which can be supported by an underlying XDS environment. The broad expectation is to use DocumentReference for DocumentEntry, DocumentManifest for SubmissionSet, and List for Folders. The inclusion of other FHIR resources as needed. The Provide Document Bundle is a bundle of the various resources necessary to be equivalent to the XDS Provide And Register Document Set-b [ITI-41]. The Find Document References will query on DocumentReference resources. The Find Document Manifests will query on DocumentManifest resources. 
* MHD_002: Use of the IUA Profile is recommended, but not mandated as there are plenty of HTTP-based security models that layer in between the low-level transport (TCP) and the HTTP encoding. These security models can be layered in without modifying the characteristics of this profile. Use of TLS is encouraged, specifically as profiled in ATNA, but is not mandated. The IUA Profile includes guidance on the use of the current common implementations of OpenID Connect and OAuth 2. 
* MHD_027: The Provide Document Bundle transaction allows for referencing the document content or including the document content. This is a capability not included in XDS for a Document Source but is reasonable for a Document Recipient to implement. Does IHE need to define a Create Document type transaction so that the Document Source could publish before using references in the Provide Document Bundle Transaction? Resolution: there is expectation of supporting this in the future.
* MHD_031: This version of MHD supports Replace operations. 
* MHD_032: This version of MHD supports other Association types. 
* MHD_033: This version of MHD provides only minimal support for Folders. A Document Source can create Folders, and update Folders. A Document Responder can return Folders related to other queries. However, there is no defined method to search for Folders. Searching for Folders, as FHIR List resources, should be obvious. 
* MHD_025: This version of MHD is based on HL7 FHIR DSTU2. Lessons learned were folded into HL7 FHIR for DSTU2 under a joint effort of IHE and HL7. Revisions of MHD are not expected to be backward compatible, until FHIR goes normative and MHD goes Final Text.
* MHD_026: DSTU2 has aligned the use of typeCode as DocumentReference.type, and classCode as DocumentReference.class. 
* MHD_030: Include support for ReferenceIdList
* MHD_034: This version of MHD identifies sourcePatient and Author resources as contained within the DocumentReference, and DocumentManifest. As FHIR defines ‘contained’ resources, these have no existence outside of their containment and are carried only within the original resource in which they were contained. This works well to support the XDS method of revision on DocumentEntry and SubmissionSet. This presents a conflict with the XDS Affinity Domain-managed Patient identity. We need experience on how to resolve.
* MHD_035: FHIR does not provide an ad-hoc metadata extension mechanism like custom slots in XDS. 