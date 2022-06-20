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
            <sch:assert test="name(/node())='query:QueryResponse'"
                >Root element of a query response document must be query:QueryResponse</sch:assert>
        </sch:rule>
    </sch:pattern>
    

    <sch:pattern>
        <sch:rule context="query:QueryResponse">
            <sch:assert test="@status='urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Failure'"
                >The status of an unsuccessful OOTS response must be Failure</sch:assert>            
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="query:QueryResponse">
            <sch:assert test="count(rs:Exception)>0"
                >An OOTS error response must have one or more Exception elements</sch:assert>
            <sch:assert test="count(rim:Slot[@name='SpecificationIdentifier'])=1"
                >An OOTS error response must have one SpecificationIdentifier slot</sch:assert>
            <sch:assert test="count(rim:Slot[@name='EvidenceResponseIdentifier'])=1"
                >An OOTS error response must have one EvidenceResponseIdentifier slot</sch:assert>
            <sch:assert test="count(rim:Slot[@name='IssueDateTime'])=1"
                >An OOTS error response must have one IssueDateTime slot</sch:assert>
            <sch:assert test="count(rim:Slot[@name='EvidenceRequester'])=1"
                >An OOTS error response must have one EvidenceRequester slot</sch:assert>
            <sch:assert test="count(rim:Slot[@name='ErrorProvider'])=1"
                >An OOTS error response must have one ErrorProvider slot</sch:assert>
        </sch:rule>
    </sch:pattern>
       
    <sch:pattern>
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
        <sch:rule context="query:QueryResponse/rim:Slot[@name='EvidenceRequester']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='AnyValueType'"
                >Slot type value for EvidenceRequester must be rim:AnyValueType</sch:assert>
            <sch:assert test="sdg:Agent"
                >An OOTS response EvidenceRequester slot must have one sdg:Agent element.</sch:assert>
        </sch:rule>
        <sch:rule context="query:QueryResponse/rim:Slot[@name='ErrorProvider']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='AnyValueType'"
                >Slot type value for ErrorProvider must be rim:AnyValueType</sch:assert>
            <sch:assert test="sdg:Agent"
                >An OOTS response ErrorProvider slot must have one sdg:Agent element.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="rs:Exception">
            <sch:assert test="count(rim:Slot[@name='Timestamp'])=1"
                >An OOTS Exception must have one Timestamp Slot</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- PreviewDescription and PreviewLocation are only present when PreviewLocation is present -->
    
    <sch:pattern>
        <sch:rule context="rs:Exception[rim:Slot[@name='PreviewMethod']]">
            <sch:assert test="count(rim:Slot[@name='PreviewLocation'])=1"
                >If an OOTS Exception has a PreviewMethod Slot, it must have exactly one PreviewLocation Slot</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="rs:Exception[rim:Slot[@name='PreviewDescription']]">
            <sch:assert test="count(rim:Slot[@name='PreviewLocation'])=1"
                >If an OOTS Exception has a PreviewDescription Slot, it must have exactly one PreviewLocation Slot</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- Data types for Exception slot values-->
    
    <sch:pattern>
        <sch:rule context="rs:Exception/rim:Slot[@name='PreviewLocation']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='StringValueType'"
                >Slot type value for PreviewLocation must be rim:StringValueType</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="rs:Exception/rim:Slot[@name='PreviewMethod']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='StringValueType'"
                >Slot type value for PreviewMethod must be rim:StringValueType</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="rs:Exception/rim:Slot[@name='PreviewDescription']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='InternationalStringValueType'"
                >Slot type value for PreviewDescription must be rim:InternationalStringValueType</sch:assert>
        </sch:rule>
    </sch:pattern>
    
</sch:schema>