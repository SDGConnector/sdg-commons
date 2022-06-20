<?xml version="1.0" encoding="UTF-8"?>
<sch:schema 
    xmlns:sch="http://purl.oclc.org/dsdl/schematron" >
    
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
        <!-- 
            If Response is Success there is only a RegistryObjectList 
            If Response is Failure then there is only an Exception 
        -->
        <sch:rule context="query:QueryResponse[
            @status='urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Success']">
            <sch:assert test="count(rim:RegistryObjectList) = 1"
                >A successful OOTS response includes a RegistryObjectList</sch:assert>
            <sch:assert test="count(rs:Exception) = 0"
                >A successful OOTS response does not include an Exception</sch:assert>
        </sch:rule>       
        <sch:rule context="query:QueryResponse[
            @status='urn:oasis:names:tc:ebxml-regrep:ResponseStatusType:Failure']">
            <sch:assert test="count(rim:RegistryObjectList) = 0"
                >An unsuccessful OOTS response does not include a RegistryObjectList</sch:assert>
            <sch:assert test="count(rs:Exception) = 1"
                >An unsuccessful OOTS response includes an Exception</sch:assert>
        </sch:rule>       
    </sch:pattern>

    <sch:pattern>
        <sch:rule context="rim:RegistryObject">
            <sch:assert test="rim:Slot[@name='Requirement']"
                >A registry object in an EB response must contain a Requirement Slot</sch:assert>
        </sch:rule>
        <sch:rule context="rim:RegistryObject">
            <sch:assert test="count(rim:Slot) = 1"
                >A registry object in an EB response must contain one and only one Slot</sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <sch:rule context="rim:Slot[@name='Requirement']/rim:SlotValue">
            <sch:let name="st"  value="substring-after(@xsi:type, ':')" />
            <sch:assert test="$st ='AnyValueType'"
                >The type of a Requirement Slot must be rim:AnyValueType  <sch:value-of select="$st"/></sch:assert>
            <sch:assert test="count(sdg:Requirement)=1"
                >A Requirement Slot must contain one sdg:Requirement</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- A RegistryObjectList can be empty !? 
            <sch:pattern>
                <sch:rule context="rim:RegistryObjectList">
                    <sch:assert test="count(rim:RegistryObject) > 0"
                        >A RegistryObjectList must include at least one RegistryObject</sch:assert>
                </sch:rule>
            </sch:pattern>
    -->
    
    <!-- The following is specific to Get Evidence Types for Requirement --> 

   
</sch:schema>