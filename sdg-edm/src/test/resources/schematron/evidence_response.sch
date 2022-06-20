<?xml version="1.0" encoding="UTF-8"?>
<sch:schema 
    xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt">
    
    <sch:ns uri="http://data.europa.eu/p4s" prefix="sdg"/>
    <sch:ns uri="urn:oasis:names:tc:ebxml-regrep:xsd:rs:4.0" prefix="rs"/>
    <sch:ns uri="urn:oasis:names:tc:ebxml-regrep:xsd:rim:4.0" prefix="rim"/>
    <sch:ns uri="urn:oasis:names:tc:ebxml-regrep:xsd:query:4.0" prefix="query"/>
    <sch:ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
    
    <sch:pattern>
        <sch:rule context="/node()">
            <sch:let name="ln" value="local-name(/node())"/>
            <sch:assert test="$ln ='QueryResponse'"
                >Root element of a query response document must be QueryResponse</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="/node()">
            <sch:let name="ns" value="namespace-uri(/node())"/>
            <sch:assert test="$ns ='urn:oasis:names:tc:ebxml-regrep:xsd:query:4.0'"
                >Namespace of root element of a query response document must be urn:oasis:names:tc:ebxml-regrep:xsd:query:4.0</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    
    
    <sch:pattern>
        <sch:rule context="query:QueryResponse">
            <sch:assert test="@status='urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Success' 
                or @status='urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Unavailable'"
                >The status of a successful OOTS response must be Success or Unavailable</sch:assert>
            
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <!-- 
            If Response is Success RegistryObjectList must be non-empty
        -->
        <sch:rule context="query:QueryResponse[
            @status='urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Success']/rim:RegistryObjectList">
            <sch:assert test="count(rim:RegistryObject) > 0"
                >In a successful OOTS response the RegistryObjectList must not be empty                
            </sch:assert>
        </sch:rule>       
    </sch:pattern>
    
    
    
    <sch:pattern >
        <sch:rule context="query:QueryResponse">

            <sch:assert test="count(child::rim:Slot[@name='SpecificationIdentifier'])=1"
                >An OOTS evidence response must have a single SpecificationIdentifier slot.</sch:assert>
            
            <sch:assert test="count(child::rim:Slot[@name='EvidenceResponseIdentifier'])=1"
                >An OOTS evidence response must have a single EvidenceResponseIdentifier slot.</sch:assert>
            
            <sch:assert test="count(child::rim:Slot[@name='IssueDateTime'])=1"
                >An OOTS evidence response must have a single IssueDateTime slot.</sch:assert>
            
            <sch:assert test="count(child::rim:Slot[@name='ResponseAvailableDateTime'])&lt;2"
                >An OOTS evidence response must have at most one ResponseAvailableDateTime slot.</sch:assert>
            
            <sch:assert test="count(child::rim:Slot[@name='EvidenceRequester'])=1"
                >An OOTS evidence response must have a single EvidenceRequester slot.</sch:assert>
            
            <sch:assert test="count(child::rim:Slot[@name='EvidenceProvider'])=1"
                >An OOTS evidence response must have a single EvidenceProvider slot.</sch:assert>

            <!-- 
            Maybe add assertion that report any slots with unexpected values?  
            For now they are just ignored. 
            --> 

        </sch:rule>
    </sch:pattern>
    
    <sch:pattern> 
        <!-- Rules for data types of specific slots in responses -->
        <sch:rule context="query:QueryResponse/rim:Slot[@name='SpecificationIdentifier']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='StringValueType'"
                >Slot type value for SpecificationIdentifier must be rim:StringValueType</sch:assert>
        </sch:rule>

        <sch:rule context="query:QueryResponse/rim:Slot[@name='EvidenceResponseIdentifier']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='StringValueType'"
                >Slot type value for EvidenceResponseIdentifier must be rim:StringValueType</sch:assert>
        </sch:rule>
        
        <sch:rule context="query:QueryResponse/rim:Slot[@name='IssueDateTime']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='DateTimeValueType'"
                >Slot type value for IssueDateTime must be rim:DateTimeValueType</sch:assert>
        </sch:rule>
        
        <sch:rule context="query:QueryResponse/rim:Slot[@name='ResponseAvailableDateTime']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='DateTimeValueType'"
                >Slot type value for ResponseAvailableDateTime must be rim:DateTimeValueType</sch:assert>
        </sch:rule>
        
        <sch:rule context="query:QueryResponse/rim:Slot[@name='EvidenceRequester']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='AnyValueType'"
                >Slot type value for EvidenceRequester must be rim:AnyValueType</sch:assert>
            <sch:assert test="sdg:Agent"
                >An OOTS response EvidenceRequester slot must have a single sdg:Agent element.</sch:assert>
        </sch:rule>
        
        <sch:rule context="query:QueryResponse/rim:Slot[@name='EvidenceProvider']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='AnyValueType'"
                >Slot type value for EvidenceProvider must be rim:AnyValueType</sch:assert>
            <sch:assert test="sdg:Agent"
                >An OOTS response EvidenceProvider slot must have a single sdg:Agent element.</sch:assert>
        </sch:rule>
        
    </sch:pattern>
    
    <sch:pattern>
        <!-- Registry Object -->
        <sch:rule context="query:QueryResponse//rim:RegistryObject">
                <sch:assert test="count(child::rim:Slot[@name='EvidenceMetadata'])=1"
                >An OOTS registry object must have a single EvidenceMetadata slot.</sch:assert>
        </sch:rule>

        <sch:rule context="query:QueryResponse//rim:RegistryObject/rim:Slot[@name='EvidenceMetadata']/rim:SlotValue">
            <sch:assert test="sdg:Evidence"
                >An OOTS registry object  EvidenceMetadata slot must have a single Evidence element.</sch:assert>
        </sch:rule>
 
        <!-- Check that a referenced evidence payload has syntax for an AS4 MIME part reference -->
        <sch:rule context="query:QueryResponse//rim:RepositoryItemRef">
            <sch:assert test="@xlink:href"
                >A repository item reference must contain an xlink:href attribute</sch:assert>
            <sch:assert test="@xlink:href[contains(.,'@')]"
                >A repository item reference must reference a MIME part, so it must contain '@'</sch:assert>
            <sch:assert test="@xlink:href[starts-with(.,'cid:')]"
                >A repository item reference must reference a MIME part, so it must start with 'cid:'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
</sch:schema>