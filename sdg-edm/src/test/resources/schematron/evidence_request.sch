<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt">
    
    <sch:ns uri="http://data.europa.eu/p4s" prefix="sdg"/>
    <sch:ns uri="urn:oasis:names:tc:ebxml-regrep:xsd:rs:4.0" prefix="rs"/>
    <sch:ns uri="urn:oasis:names:tc:ebxml-regrep:xsd:rim:4.0" prefix="rim"/>
    <sch:ns uri="urn:oasis:names:tc:ebxml-regrep:xsd:query:4.0" prefix="query"/>
    <sch:ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
    
    <sch:pattern>
        <sch:rule context="/node()">
            <sch:let name="ln" value="local-name(/node())"/>
            <sch:assert test="$ln ='QueryRequest'"
                >Root element of a query request document must be QueryRequest</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="/node()">
            <sch:let name="ns" value="namespace-uri(/node())"/>
            <sch:assert test="$ns ='urn:oasis:names:tc:ebxml-regrep:xsd:query:4.0'"
                >Namespace of root element of a query request document must be urn:oasis:names:tc:ebxml-regrep:xsd:query:4.0</sch:assert>
        </sch:rule>
    </sch:pattern>
        
    <sch:pattern >
        <sch:rule context="query:QueryRequest">
            
            <sch:assert test="count(child::rim:Slot[@name='SpecificationIdentifier'])=1"
                >An OOTS evidence request must have a single SpecificationIdentifier slot.</sch:assert>
            
            <sch:assert test="count(child::rim:Slot[@name='IssueDateTime'])=1"
                >An OOTS evidence response must have a single IssueDateTime slot.</sch:assert>
            
            <sch:assert test="count(child::rim:Slot[@name='Procedure'])&lt;2"
                >An OOTS evidence request may have a single Procedure slot.</sch:assert>
            
            <sch:assert test="count(child::rim:Slot[@name='PreviewLocation'])&lt;2"
                >An OOTS evidence request may have a single Procedure slot.</sch:assert>
            
            <sch:assert test="count(child::rim:Slot[@name='PossibilityForPreview'])=1"
                >An OOTS evidence request must have a single PossibilityForPreview slot.</sch:assert>
            
            <sch:assert test="count(child::rim:Slot[@name='ExplicitRequestGiven'])=1"
                >An OOTS evidence request must have a single ExplicitRequestGiven slot.</sch:assert>

            <sch:assert test="count(child::rim:Slot[@name='Requirements'])&lt;2"
                >An OOTS evidence request may have a single Requirements slot.</sch:assert>
            
            <sch:assert test="count(child::rim:Slot[@name='EvidenceRequester'])=1"
                >An OOTS evidence request must have a single EvidenceRequester slot.</sch:assert>
            
            <sch:assert test="count(child::rim:Slot[@name='EvidenceProvider'])=1"
                >An OOTS evidence request must have a single EvidenceProvider slot.</sch:assert>
            
            <!-- 
            Maybe add assertion that report any slots with unexpected values?  
            For now they are just ignored. 
            --> 
            
        </sch:rule>
    </sch:pattern>

    <sch:pattern> 
        <!-- Rules for data types of specific slots in requests -->
        <sch:rule context="query:QueryRequest/rim:Slot[@name='SpecificationIdentifier']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='StringValueType'"
                >Slot type value for SpecificationIdentifier must be rim:StringValueType</sch:assert>
        </sch:rule>
        
        <sch:rule context="query:QueryRequest/rim:Slot[@name='IssueDateTime']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='DateTimeValueType'"
                >Slot type value for IssueDateTime must be rim:DateTimeValueType</sch:assert>
        </sch:rule>
        
        <sch:rule context="query:QueryRequest/rim:Slot[@name='EvidenceRequester']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='CollectionValueType'"
                >Slot type value for EvidenceRequester must be rim:CollectionValueType</sch:assert>
            <sch:assert test="rim:Element/sdg:Agent"
                >An OOTS response EvidenceRequester slot must have rim:Element/sdg:Agent content.</sch:assert>
        </sch:rule>
        
        <sch:rule context="query:QueryRequest/rim:Slot[@name='EvidenceProvider']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='AnyValueType'"
                >Slot type value for EvidenceProvider must be rim:AnyValueType</sch:assert>
            <sch:assert test="sdg:Agent"
                >An OOTS response EvidenceProvider slot must have a single sdg:Agent element.</sch:assert>
        </sch:rule>
        
        <sch:rule context="query:QueryRequest/rim:Slot[@name='PreviewLocation']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='StringValueType'"
                >Slot type value for PreviewLocation must be rim:StringValueType</sch:assert>
        </sch:rule>
        
        <sch:rule context="query:QueryRequest/rim:Slot[@name='PossibilityForPreview']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='BooleanValueType'"
                >Slot type value for PossibilityForPreview must be rim:BooleanValueType</sch:assert>
        </sch:rule>

        <sch:rule context="query:QueryRequest/rim:Slot[@name='ExplicitRequestGiven']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='BooleanValueType'"
                >Slot type value for ExplicitRequestGiven must be rim:BooleanValueType</sch:assert>
        </sch:rule>

        <sch:rule context="query:QueryRequest/rim:Slot[@name='Requirements']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='CollectionValueType'"
                >Slot type value for Requirements must be rim:CollectionValueType</sch:assert>
        </sch:rule>
    </sch:pattern>
    

    <sch:pattern >
        <sch:rule context="query:Query">
            <sch:assert test="count(child::rim:Slot[@name='EvidenceRequest'])=1"
                >An OOTS evidence request query element must have a single EvidenceRequest slot.</sch:assert>
            <sch:assert test="count(child::rim:Slot[@name='NaturalPerson'])+count(child::rim:Slot[@name='LegalPerson'])=1"
                >An OOTS evidence request query element must have a NaturalPerson or LegalPerson slot.</sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern >
        <sch:rule context="query:Query/rim:Slot[@name='EvidenceRequest']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='AnyValueType'"
                >Slot type value for EvidenceRequest must be rim:AnyValueType</sch:assert>
            <sch:assert test="sdg:DataServiceEvidenceType"
                >An OOTS query EvidenceRequest slot must have a single sdg:DataServiceEvidenceType.</sch:assert>            
        </sch:rule>
    </sch:pattern>
    
    
    <sch:pattern >
        <sch:rule context="query:Query/rim:Slot[@name='NaturalPerson']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='AnyValueType'"
                >Slot type value for NaturalPerson must be rim:AnyValueType</sch:assert>
            <sch:assert test="sdg:Person"
                >An OOTS query NaturalPerson slot must have a single sdg:Person element.</sch:assert>            
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern >
        <sch:rule context="query:Query/rim:Slot[@name='LegalPerson']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='AnyValueType'"
                >Slot type value for LegalPerson must be rim:AnyValueType</sch:assert>
            <sch:assert test="sdg:LegalPerson"
                >An OOTS query LegalPerson slot must have a single sdg:LegalPerson element.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern >
        <sch:rule context="query:Query/rim:Slot[@name='AuthorizedRepresentative']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='AnyValueType'"
                >Slot type value for AuthorizedRepresentative must be rim:AnyValueType</sch:assert>
            <sch:assert test="sdg:Person"
                >An OOTS query NaturalAuthorizedRepresentative slot must have a single sdg:Person element.</sch:assert>            
        </sch:rule>
    </sch:pattern>
    
    


</sch:schema>