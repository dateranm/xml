<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:pe="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
	xmlns:pe1="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2"
	xmlns:pe2="urn:oasis:names:specification:ubl:schema:xsd:DebitNote-2"
	xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
	xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
	xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
	xmlns:sac="urn:sunat:names:specification:ubl:peru:schema:xsd:SunatAggregateComponents-1"
	xmlns:ccts="urn:un:unece:uncefact:documentation:2"
	xmlns:qdt="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDatatypes-2"
	xmlns:udt="urn:un:unece:uncefact:data:specification:UnqualifiedDataTypesSchemaModule:2"
	exclude-result-prefixes="cac cbc ccts ds ext pe pe1 pe2 qdt sac udt xsi">

	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" omit-xml-declaration="yes"/>
	<xsl:template name="son-pesos">
		<table border="0" cellpadding="1" cellspacing="1" width="100%">
			<tr>
				<td width="65%" colspan="2" rowspan="2">
					<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
						<strong>SON: </strong>
						<xsl:call-template name="RetourneValAd">
							<xsl:with-param name="NumAd" select="8"/>
						</xsl:call-template>					
					</font>
				</td>
			</tr>			
		</table>
	</xsl:template>

	<xsl:template name="Total">
		<table width="100%" cellpadding="0" cellspacing="0" border="1">
			<tbody>
				<tr bgcolor="silver">
					<td align="center" width="15%">
						<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
							<Strong>OP. GRAVADO</Strong>
						</font>
					</td>
					<td align="center" width="8%">
						<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
							<Strong>OP. INAFECTA</Strong>
						</font>
					</td>
					<td align="center" width="8%">
						<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
							<Strong>OP. EXONERADA</Strong>
						</font>
					</td>
					<td align="center" width="8%">
						<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
							<Strong>DSCTO GLOBAL</Strong>
						</font>
					</td>
					<td align="center" width="8%">
						<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
							<Strong>I.G.V.</Strong>
						</font>
					</td>
					<td align="center" width="18%">
						<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
							<Strong>
								IMPORTE TOTAL
								<xsl:variable name="CTSJuanchoQuiereIncoterm">
									<xsl:call-template name="RetourneValAd">
										<xsl:with-param name="NumAd" select="40"/>
									</xsl:call-template>
								</xsl:variable>
								<xsl:if test="$CTSJuanchoQuiereIncoterm != ''">
									(<xsl:value-of select="$CTSJuanchoQuiereIncoterm"/>)
								</xsl:if>
								<xsl:call-template name="CTSJuanchoQuiereElSimbolo"/>
							</Strong>
						</font>
					</td>
				</tr>

				<tr>
					<xsl:if test="/pe:Invoice/cac:InvoiceLine">
						<!--Total Grabado-->
						<td align="right" width="15%">
							<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
								<xsl:for-each select="//ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/sac:AdditionalInformation/sac:AdditionalMonetaryTotal">
			                    	<xsl:if test="cbc:ID = '1001'">
										<xsl:value-of select="format-number(cbc:PayableAmount, '###,###,##0.00', 'pen')"/>&#160;
							 		</xsl:if>
			                  	</xsl:for-each>
			               	</font>
						</td>
						<!--Total Inafecto-->
						<td align="right" width="8%">
							<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
			                	<xsl:for-each select="//ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/sac:AdditionalInformation/sac:AdditionalMonetaryTotal">
			                    	<xsl:if test="cbc:ID = '1002'">
										<xsl:value-of select="format-number(cbc:PayableAmount, '###,###,##0.00', 'pen')"/>&#160;
							 		</xsl:if>
			                  	</xsl:for-each>                  
			            	</font>
						</td>
						<!--Total Exonerado-->
						<td align="right" width="8%">
							<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
			                	<xsl:for-each select="//ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/sac:AdditionalInformation/sac:AdditionalMonetaryTotal">
			                    	<xsl:if test="cbc:ID = '1003'">
										<xsl:value-of select="format-number(cbc:PayableAmount, '###,###,##0.00', 'pen')"/>&#160;
							 		</xsl:if>
			                  	</xsl:for-each>
			               	</font>
						</td>
						<!--Descuento global - DPP-->
						<td align="right" width="8%">
							<xsl:variable name="DsctoGlobal">
								<xsl:value-of select="0" />
								<xsl:for-each select="//pe:Invoice/cac:LegalMonetaryTotal">
    								<xsl:value-of select="cbc:AllowanceTotalAmount" />
        						</xsl:for-each>
							</xsl:variable>
							<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
	                  			<xsl:value-of select="format-number($DsctoGlobal, '###,###,##0.00', 'pen')"/>
					  		</font>
						</td>
						<!--Total IGV-->
						<td align="right" width="8%">
							<!--Para boletas y facturas-->
							<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
								<xsl:for-each select="/pe:Invoice/cac:TaxTotal">
       								<xsl:if test="cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:ID = '1000'">
										<xsl:value-of select="format-number(cac:TaxSubtotal/cbc:TaxAmount, '###,###,##0.00', 'pen')"/>
									</xsl:if>
								</xsl:for-each>
							</font>
						</td>
						<!--Importe Total-->
						<td align="right" width="18%">
							<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
								<xsl:if test="//cac:LegalMonetaryTotal/cbc:PayableAmount != ''">
									<xsl:value-of select="format-number(//cac:LegalMonetaryTotal/cbc:PayableAmount, '###,###,##0.00', 'pen')"/>
								</xsl:if>
							</font>
						</td>
					</xsl:if>

					<xsl:if test="/pe1:CreditNote/cac:CreditNoteLine">
						<!--Total Grabado-->
						<td align="right" width="15%">
							<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
			                	<xsl:for-each select="//ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/sac:AdditionalInformation/sac:AdditionalMonetaryTotal">
			                    	<xsl:if test="cbc:ID = '1001'">
										<xsl:value-of select="format-number(cbc:PayableAmount, '###,###,##0.00', 'pen')"/>&#160;
							 		</xsl:if>
			                  	</xsl:for-each>
			               	</font>
						</td>
						<!--Total Inafecto-->
						<td align="right" width="8%">
							<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
			                	<xsl:for-each select="//ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/sac:AdditionalInformation/sac:AdditionalMonetaryTotal">
			                    	<xsl:if test="cbc:ID = '1002'">
										<xsl:value-of select="format-number(cbc:PayableAmount, '###,###,##0.00', 'pen')"/>&#160;
							 		</xsl:if>
			                  	</xsl:for-each>
			               	</font>
						</td>
						<!--Total Exonerado-->
						<td align="right" width="8%">
							<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
			                	<xsl:for-each select="//ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/sac:AdditionalInformation/sac:AdditionalMonetaryTotal">
			                    	<xsl:if test="cbc:ID = '1003'">
										<xsl:value-of select="format-number(cbc:PayableAmount, '###,###,##0.00', 'pen')"/>&#160;
							 		</xsl:if>
			                  	</xsl:for-each>
			               	</font>
						</td>
						<!--Descuento global - DPP-->
						<td align="right" width="8%">
							<xsl:variable name="DsctoGlobal">
								<xsl:value-of select="0" />
								<xsl:for-each select="//pe1:CreditNote/cac:LegalMonetaryTotal">
    								<xsl:value-of select="cbc:AllowanceTotalAmount" />
        						</xsl:for-each>
							</xsl:variable>
							<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
	                  			<xsl:value-of select="format-number($DsctoGlobal, '###,###,##0.00', 'pen')"/>
					  		</font>
						</td>
						<!--IGV-->
						<td align="right" width="8%">
							<xsl:for-each select="/pe1:CreditNote/cac:TaxTotal">
								<xsl:if test="cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:ID = '1000'">
									<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
										<xsl:value-of select="format-number(cac:TaxSubtotal/cbc:TaxAmount, '###,###,##0.00', 'pen')"/>&#160;
									</font>
								</xsl:if>
							</xsl:for-each>
						</td>
						<!--Importe Total-->
						<td align="right" width="18%">
							<xsl:if test="//cac:LegalMonetaryTotal/cbc:PayableAmount != ''">
								<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
									<xsl:value-of select="format-number(//cac:LegalMonetaryTotal/cbc:PayableAmount, '###,###,##0.00', 'pen')"/>&#160;
	   							</font>
							</xsl:if>
						</td>
					</xsl:if>

					<xsl:if test="/pe2:DebitNote/cac:DebitNoteLine">
						<!--Total Grabado-->
						<td align="right" width="15%">
							<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
			                	<xsl:for-each select="//ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/sac:AdditionalInformation/sac:AdditionalMonetaryTotal">
			                    	<xsl:if test="cbc:ID = '1001'">
										<xsl:value-of select="format-number(cbc:PayableAmount, '###,###,##0.00', 'pen')"/>&#160;
							 		</xsl:if>
			                  	</xsl:for-each>
			               	</font>
						</td>
						<!--Total Inafecto-->
						<td align="right" width="8%">
							<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
			                	<xsl:for-each select="//ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/sac:AdditionalInformation/sac:AdditionalMonetaryTotal">
			                    	<xsl:if test="cbc:ID = '1002'">
										<xsl:value-of select="format-number(cbc:PayableAmount, '###,###,##0.00', 'pen')"/>&#160;
							 		</xsl:if>
			                  	</xsl:for-each>
			               	</font>
						</td>
						<!--Total Exonerado-->
						<td align="right" width="8%">
							<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
			                	<xsl:for-each select="//ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/sac:AdditionalInformation/sac:AdditionalMonetaryTotal">
			                    	<xsl:if test="cbc:ID = '1003'">
										<xsl:value-of select="format-number(cbc:PayableAmount, '###,###,##0.00', 'pen')"/>&#160;
							 		</xsl:if>
			                  	</xsl:for-each>
			               	</font>
						</td>
						<!--Descuento global - DPP-->
						<td align="right" width="8%">
							<xsl:variable name="DsctoGlobal">
								<xsl:value-of select="0" />
								<xsl:for-each select="//pe2:DebitNote/cac:LegalMonetaryTotal">
    								<xsl:value-of select="cbc:AllowanceTotalAmount" />
        						</xsl:for-each>
							</xsl:variable>
							<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
	                  			<xsl:value-of select="format-number($DsctoGlobal, '###,###,##0.00', 'pen')"/>
					  		</font>
						</td>
						<!--IGV-->
						<td align="right" width="8%">
							<xsl:for-each select="/pe2:DebitNote/cac:TaxTotal">
								<xsl:if test="cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:ID = '1000'">
									<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
										<xsl:value-of select="format-number(cac:TaxSubtotal/cbc:TaxAmount, '###,###,##0.00', 'pen')"/>&#160;
									</font>
								</xsl:if>
							</xsl:for-each>
						</td>
						<!--Importe Total-->
						<td align="right" width="18%">
							<xsl:if test="//cac:RequestedMonetaryTotal/cbc:PayableAmount != ''">	
       							<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
									<xsl:value-of select="format-number(//cac:RequestedMonetaryTotal/cbc:PayableAmount, '###,###,##0.00', 'pen')"/>&#160;
	   							</font>
							</xsl:if>
						</td>
					</xsl:if>
				</tr>
			</tbody>
		</table>
	</xsl:template>

	<xsl:template name="DatosReferencia">
		<table width="100%" border="0" cellpadding="1" rules="groups">
			<tr>
			 	<td width="65%">
					<table border="0" width="100%">
						<tr>
							<td width="30%" align="left">
								<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
									<xsl:call-template name="RetourneValAd"><xsl:with-param name="NumAd" select="9"/></xsl:call-template>
								</font>
							</td>

						</tr>
						<tr>
							<td width="30%" align="left">
								<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
									<xsl:call-template name="RetourneValAd"><xsl:with-param name="NumAd" select="10"/></xsl:call-template>
								</font>
							</td>
						</tr>
						<tr>
							<td width="30%" align="left">
								<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
									<xsl:call-template name="RetourneValAd"><xsl:with-param name="NumAd" select="11"/></xsl:call-template>
								</font>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>

	</xsl:template>

	<xsl:template name="fecha_ddmmaa_ref">
		<xsl:variable name="aa">
			<xsl:value-of select="substring-before(FchRef, '-')"/>
		</xsl:variable>
		<xsl:variable name="mmdd">
			<xsl:value-of select="substring-after(FchRef, '-')"/>
		</xsl:variable>
		<xsl:variable name="mm">
			<xsl:value-of select="substring-before($mmdd, '-')"/>
		</xsl:variable>
		<xsl:variable name="dd">
			<xsl:value-of select="substring-after($mmdd, '-')"/>
		</xsl:variable>
		<xsl:value-of select="concat($dd, '-', $mm, '-' , $aa)"/>
	</xsl:template>

	<xsl:template name="CTSJuanchoQuiereElSimbolo">
		<xsl:choose>
			<xsl:when test="/pe:Invoice/cbc:DocumentCurrencyCode = 'PEN'">(S/.)</xsl:when>
			<xsl:when test="/pe:Invoice/cbc:DocumentCurrencyCode = 'USD'">(USD)</xsl:when>
			<xsl:when test="/pe:Invoice/cbc:DocumentCurrencyCode = 'EUR'">(EUR)</xsl:when>
			<xsl:when test="/pe1:CreditNote/cbc:DocumentCurrencyCode = 'PEN'">(S/.)</xsl:when>
			<xsl:when test="/pe1:CreditNote/cbc:DocumentCurrencyCode = 'USD'">(USD)</xsl:when>
			<xsl:when test="/pe1:CreditNote/cbc:DocumentCurrencyCode = 'EUR'">(EUR)</xsl:when>
			<xsl:when test="/pe2:DebitNote/cbc:DocumentCurrencyCode = 'PEN'">(S/.)</xsl:when>
			<xsl:when test="/pe2:DebitNote/cbc:DocumentCurrencyCode = 'USD'">(USD)</xsl:when>
			<xsl:when test="/pe2:DebitNote/cbc:DocumentCurrencyCode = 'EUR'">(EUR)</xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="/">
		<html>
			<head></head>
			<body/>
		</html>
	</xsl:template>
</xsl:stylesheet>
