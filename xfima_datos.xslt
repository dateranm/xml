<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:pe="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
	xmlns:pe1="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2"
	xmlns:pe2="urn:oasis:names:specification:ubl:schema:xsd:DebitNote-2"
	xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
	xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
	xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2">

	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" omit-xml-declaration="yes"/>

	<xsl:template name="DatosReceptor">
		<table width="100%" cellpadding="1" cellspacing="0" border="0">
			<tr>
				<td>
					<table width="100%" cellpadding="1" cellspacing="1" border="2" rules="none">
						<tr >
							<td width="10%">
								<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
									<Strong>SEÑOR(ES)</Strong>
								</font>
							</td>
							<td width="35%">
								<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
									<Strong>: </Strong>
									<xsl:value-of select="//cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName"/>
								</font>
							</td>
							<td width="5%">
								<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
									<Strong>COD.</Strong>
								</font>
							</td>
							<td width="15%">
								<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
									<Strong>: </Strong>
									<xsl:call-template name="RetourneValAd"><xsl:with-param name="NumAd" select="1"/></xsl:call-template>
								</font>
							</td>
							<td width="10%">
								<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
									<Strong>FECHA DE EMISIÓN</Strong>
								</font>
							</td>
							<td width="15%">
								<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
									<Strong>: </Strong>
									<xsl:value-of select="//cbc:IssueDate"/>
								</font>
							</td>
						</tr>
						<tr>
							<td width="10%">
								<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
									<Strong>DIRECCIÓN</Strong>
								</font>
							</td>
							<td width="35%">
								<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
									<Strong>: </Strong>
									<xsl:value-of select="//cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cbc:Description"/>
								</font>
							</td>
							<td width="5%"/>
							<td width="15"/>
							<td width="10%">
								<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
									<!--<Strong>O. DE VENTA</Strong>-->
									<strong>
									<xsl:template name="oventa">
										<xsl:choose>
											<xsl:when test="/pe:Invoice/cbc:InvoiceTypeCode = '01'">O. DE VENTA</xsl:when>
											<xsl:when test="/pe:Invoice/cbc:InvoiceTypeCode = '03'">O. DE VENTA</xsl:when>
											<xsl:when test="/pe1:CreditNote">CODIGO</xsl:when>
											<xsl:when test="/pe2:DebitNote">CODIGO</xsl:when>
											<xsl:otherwise></xsl:otherwise>
										</xsl:choose>
									</xsl:template>
									</strong>
								</font>
							</td>
							<td width="15%">
								<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
									<Strong>: </Strong>			
									<xsl:template name="oventa1">
										<xsl:choose>
											<xsl:when test="/pe:Invoice/cbc:InvoiceTypeCode = '01'">
												<xsl:call-template name="RetourneValAd"><xsl:with-param name="NumAd" select="2"/></xsl:call-template>
											</xsl:when>
											<xsl:when test="/pe:Invoice/cbc:InvoiceTypeCode = '03'">
												<xsl:call-template name="RetourneValAd"><xsl:with-param name="NumAd" select="2"/></xsl:call-template>
											</xsl:when>
											<xsl:when test="/pe1:CreditNote">
												<xsl:call-template name="RetourneValAd"><xsl:with-param name="NumAd" select="12"/></xsl:call-template>
											</xsl:when>
											<xsl:when test="/pe2:DebitNote">
												<xsl:call-template name="RetourneValAd"><xsl:with-param name="NumAd" select="12"/></xsl:call-template>
											</xsl:when>
											<xsl:otherwise></xsl:otherwise>
										</xsl:choose>
									</xsl:template>
								</font>
							</td>
						</tr>
						<tr>
							<td width="10%">
								<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
									<Strong>RUC</Strong>
								</font>
							</td>
							<td width="35%">
								<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
									<Strong>: </Strong>
									<xsl:value-of select="//cac:AccountingCustomerParty/cbc:CustomerAssignedAccountID" />
								</font>
							</td>
							<td width="5%"/>
							<td width="15"/>
							<td width="10%">
								<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
									<strong>
									<xsl:template name="ocompra">
										<xsl:choose>
											<xsl:when test="/pe:Invoice/cbc:InvoiceTypeCode = '01'">O. DE COMPRA</xsl:when>
											<xsl:when test="/pe:Invoice/cbc:InvoiceTypeCode = '03'">O. DE COMPRA</xsl:when>
											<xsl:when test="/pe1:CreditNote">O. TRABAJO</xsl:when>
											<xsl:when test="/pe2:DebitNote">O. TRABAJO</xsl:when>
											<xsl:otherwise></xsl:otherwise>
										</xsl:choose>
									</xsl:template>
									</strong>
								</font>
							</td>
							<td width="15%">
								<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
									<Strong>: </Strong>
																		<xsl:template name="oventa1">
										<xsl:choose>
											<xsl:when test="/pe:Invoice/cbc:InvoiceTypeCode = '01'">
												<xsl:call-template name="RetourneValAd"><xsl:with-param name="NumAd" select="3"/></xsl:call-template>
											</xsl:when>
											<xsl:when test="/pe:Invoice/cbc:InvoiceTypeCode = '03'">
												<xsl:call-template name="RetourneValAd"><xsl:with-param name="NumAd" select="3"/></xsl:call-template>
											</xsl:when>
											<xsl:when test="/pe1:CreditNote">
												<xsl:call-template name="RetourneValAd"><xsl:with-param name="NumAd" select="13"/></xsl:call-template>
											</xsl:when>
											<xsl:when test="/pe2:DebitNote">
												<xsl:call-template name="RetourneValAd"><xsl:with-param name="NumAd" select="13"/></xsl:call-template>
											</xsl:when>
											<xsl:otherwise></xsl:otherwise>
										</xsl:choose>
									</xsl:template>
								</font>
							</td>
						</tr>
						<tr>
							<td width="10%">
								<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
									<Strong>MONEDA</Strong>
								</font>
							</td>
							<td width="35%">
								<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
									<Strong>: </Strong>
									<xsl:call-template name="RetournerMoneda" />
								</font>
							</td>
							<td width="5%"/>
							<td width="15%"/>
							<td width="10%">
								<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
									<!--<strong>FORMA DE PAGO</strong>-->
									<strong>
									<xsl:template name="fpago">
										<xsl:choose>
											<xsl:when test="/pe:Invoice/cbc:InvoiceTypeCode = '01'">FORMA DE PAGO</xsl:when>
											<xsl:when test="/pe:Invoice/cbc:InvoiceTypeCode = '03'">FORMA DE PAGO</xsl:when>
											<xsl:when test="/pe1:CreditNote"> </xsl:when>
											<xsl:when test="/pe2:DebitNote"></xsl:when>
											<xsl:otherwise></xsl:otherwise>
										</xsl:choose>
									</xsl:template>
									</strong>
								</font>
							</td>
							<td width="15%">
								<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
									
									<xsl:template name="fpago1">
										<xsl:choose>
											<xsl:when test="/pe:Invoice/cbc:InvoiceTypeCode = '01'">
												<strong>: </strong><xsl:call-template name="RetourneValAd"><xsl:with-param name="NumAd" select="4"/></xsl:call-template>
											</xsl:when>
											<xsl:when test="/pe:Invoice/cbc:InvoiceTypeCode = '03'">
												<strong>: </strong>	<xsl:call-template name="RetourneValAd"><xsl:with-param name="NumAd" select="4"/></xsl:call-template>
											</xsl:when>
											<xsl:when test="/pe1:CreditNote"></xsl:when>
											<xsl:when test="/pe2:DebitNote"></xsl:when>
											<xsl:otherwise></xsl:otherwise>
										</xsl:choose>
									</xsl:template>
								</font>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<table width="100%" cellpadding="1" cellspacing="1" border="2" rules="none">
						<tbody>
							<tr>
								<td width="48%" align="left">
									<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
										<xsl:call-template name="RetourneValAd"><xsl:with-param name="NumAd" select="5"/></xsl:call-template>
									</font>
								</td>
							</tr>
							<tr>
								<td width="28%" align="left">
									<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
										<xsl:call-template name="RetourneValAd"><xsl:with-param name="NumAd" select="6"/></xsl:call-template>
									</font>
								</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="RetourneValAd">
		<xsl:param name="NumAd"/>

		<xsl:for-each select="//ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/pe:DatosAdicionales/pe:DatoAdicional">
			<xsl:if test="pe:Codigo = $NumAd">
				<xsl:if test="pe:Valor != '-'">
					<xsl:value-of select="pe:Valor"/>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
		<xsl:for-each select="//ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/pe1:DatosAdicionales/pe1:DatoAdicional">
			<xsl:if test="pe1:Codigo = $NumAd">
				<xsl:if test="pe1:Valor != '-'">
					<xsl:value-of select="pe1:Valor"/>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
		<xsl:for-each select="//ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/pe2:DatosAdicionales/pe2:DatoAdicional">
			<xsl:if test="pe2:Codigo = $NumAd">
				<xsl:if test="pe2:Valor != '-'">
					<xsl:value-of select="pe2:Valor"/>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="RetournerMoneda">
		<xsl:choose>
			<xsl:when test="/pe:Invoice/cbc:DocumentCurrencyCode = 'PEN'">NUEVOS SOLES</xsl:when>
			<xsl:when test="/pe:Invoice/cbc:DocumentCurrencyCode = 'USD'">DÓLARES AMERICANOS</xsl:when>
			<xsl:when test="/pe:Invoice/cbc:DocumentCurrencyCode = 'EUR'">EUROS</xsl:when>
			<xsl:when test="/pe1:CreditNote/cbc:DocumentCurrencyCode = 'PEN'">NUEVOS SOLES</xsl:when>
			<xsl:when test="/pe1:CreditNote/cbc:DocumentCurrencyCode = 'USD'">DÓLARES AMERICANOS</xsl:when>
			<xsl:when test="/pe1:CreditNote/cbc:DocumentCurrencyCode = 'EUR'">EUROS</xsl:when>
			<xsl:when test="/pe2:DebitNote/cbc:DocumentCurrencyCode = 'PEN'">NUEVOS SOLES</xsl:when>
			<xsl:when test="/pe2:DebitNote/cbc:DocumentCurrencyCode = 'USD'">DÓLARES AMERICANOS</xsl:when>
			<xsl:when test="/pe2:DebitNote/cbc:DocumentCurrencyCode = 'EUR'">EUROS</xsl:when>
			<xsl:otherwise>OTRA MONEDA</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
