<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:pe="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
    xmlns:pe1="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2"
	xmlns:pe2="urn:oasis:names:specification:ubl:schema:xsd:DebitNote-2"
	xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
    xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
	xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
    xmlns:qdt="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDatatypes-2"
	xmlns:sac="urn:sunat:names:specification:ubl:peru:schema:xsd:SunatAggregateComponents-1"
    xmlns:udt="urn:un:unece:uncefact:data:specification:UnqualifiedDataTypesSchemaModule:2"
	xmlns:ccts="urn:un:unece:uncefact:documentation:2"
	exclude-result-prefixes="cac cbc ccts ds ext pe pe1 pe2 qdt sac udt xsi">

	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" omit-xml-declaration="yes"/>
	<xsl:decimal-format name="pen" decimal-separator="." grouping-separator="," NaN="0.00"/>

	<xsl:variable name="numColBl">
		<xsl:if test="/pe:Invoice != ''">
			<xsl:value-of select="17 - count(/pe:Invoice/cac:InvoiceLine)"/>
		</xsl:if>
		<xsl:if test="/pe1:CreditNote != ''">
			<xsl:value-of select="17 - count(/pe1:CreditNote/cac:CreditNoteLine)"/>
		</xsl:if>
		<xsl:if test="/pe2:DebitNote != ''">
			<xsl:value-of select="17 - count(/pe2:DebitNote/cac:DebitNoteLine)"/>
		</xsl:if>
	</xsl:variable>
	
	<xsl:include href="xfima_encab.xslt"/>
	<xsl:include href="xfima_detalle.xslt"/>
	<xsl:include href="xfima_bottom.xslt"/>
	<xsl:include href="xfima_datos.xslt"/>
	<xsl:include href="xfima_total.xslt"/>
	
	<xsl:template match="/">
		<html xmlns:ccts="urn:un:unece:uncefact:documentation:2"
			xmlns:udt="urn:un:unece:uncefact:data:specification:UnqualifiedDataTypesSchemaModule:2"
			xmlns:qdt="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDatatypes-2"
		    xmlns:pe2="urn:oasis:names:specification:ubl:schema:xsd:DebitNote-2"
			xmlns:pe1="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2"
			xmlns:pe="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
			xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
			xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
			xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
			xmlns:sig="urn:oasis:names:specification:ubl:schema:xsd:CommonSignatureComponents-2"
			xmlns:sac="urn:oasis:names:specification:ubl:schema:xsd:SignatureAggregateComponents-2"
			xmlns:sbc="urn:oasis:names:specification:ubl:schema:xsd:SignatureBasicComponents-2">

			<head><title>Comprobante Electrónico</title></head>
			<body>
				<table cellSpacing="1" width="100%" border="0">
					<tbody>
						<tr>
							<td>
								<xsl:call-template name="Encabezado"/>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:call-template name="DatosReceptor"/>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:call-template name="DetallesEncabezado"/>
							</td>
						</tr>
						<tr>
							<td>
								<table border="0" cellSpacing="0" cellPadding="0" width="100%" align="center" heigth="100%">
									<tr>
										<td>
											<table border="0" width="100%" cellpadding="0" cellspacing="0">
												<tr>
													<td>
														<xsl:call-template name="Total"/>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td width="100%">
											<xsl:call-template name="son-pesos"/>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td width="100%">
								<table border="0" cellSpacing="0" cellPadding="0" width="100%" align="left">
									<tr>
										<td>
											<xsl:call-template name="Referencia"/>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td width="100%">
								<xsl:call-template name="DatosReferencia"/>
							</td>
						</tr>
						<tr>
							<td width="100%">
								<xsl:call-template name="bottom_hash"/>
							</td>
						</tr>
						<tr>
							<td>
								&#160;
							</td>
						</tr>
					</tbody>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
