<?xml version="1.0" encoding="UTF-8"?>
<sch:schema 
    xmlns:sch="http://purl.oclc.org/dsdl/schematron" >
    
    <sch:ns uri="http://data.europa.eu/p4s" prefix="sdg"/>
    <sch:ns uri="urn:oasis:names:tc:ebxml-regrep:xsd:rs:4.0" prefix="rs"/>
    <sch:ns uri="urn:oasis:names:tc:ebxml-regrep:xsd:rim:4.0" prefix="rim"/>
    <sch:ns uri="urn:oasis:names:tc:ebxml-regrep:xsd:query:4.0" prefix="query"/>
    <sch:ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
    
    <!-- 
        The following is specific and limited to Get Evidence Types for Requirement EB query 
        
        Use in combination with eb_query_response.sch
    --> 
    
    <sch:pattern>
        <sch:rule context="sdg:Requirement">
            <sch:assert test="count(sdg:EvidenceTypeList)>0"
                >A Requirement Slot must contain at least one EvidenceTypeList</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    
</sch:schema>