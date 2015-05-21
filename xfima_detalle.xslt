<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
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

	<xsl:template name="DetallesEncabezado">
		<table rules="cols" width="100%" border="2" cellpadding="2">
			<tbody>
				<tr bgcolor="silver">
					<td align="center" width="6%">
						<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
							<Strong>ITEM</Strong>
						</font>
					</td>
					<td align="center" width="6%">
						<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
							<Strong>CANTIDAD</Strong>
						</font>
					</td>
					<td align="center" width="41%">
						<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
							<Strong>DESCRIPCIÓN</Strong>
						</font>
					</td>
					<td align="center" width="4%">
						<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
							<Strong>UNIDAD</Strong>
						</font>
					</td>
<!--					<td align="center" width="12%">
						<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
							<Strong>LOTE</Strong>
						</font>
					</td>-->
					<td align="center" width="7%">
						<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
							<Strong>VALOR UNIT.</Strong>
						</font>
					</td>							
<!--					<td align="center" width="7%">
						<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
							<Strong>% DSCTO UNIT</Strong>
						</font>
					</td>-->
					<td align="center" width="7%">
						<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
							<Strong>PRECIO UNIT.</Strong>
						</font>
					</td>
					<td align="center" width="10%">
						<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
							<Strong>VALOR VENTA</Strong>
						</font>
					</td>
				</tr>

				<xsl:for-each select="/pe:Invoice/cac:InvoiceLine">
					<tr>
						<!--Codigo-->
						<td valign="top" align="center" width="6%">
							<font color="#000000" size="2" face="Arial, Helvetica, sans-serif">
								<xsl:value-of select="cac:Item/cac:SellersItemIdentification/cbc:ID"/>
							</font>
						</td>
						<!--Cant-->
						<td valign="top" align="right" width="6%">
							<font color="#000000" size="2" face="Arial, Helvetica, sans-serif">
								<xsl:choose>
									<xsl:when test="substring-after(cbc:InvoicedQuantity, '.') = '00'">
										<xsl:value-of select="substring-before(cbc:InvoicedQuantity, '.')"/>
									</xsl:when>
									<xsl:when test="substring-after(cbc:InvoicedQuantity, '.') = '000'">
										<xsl:value-of select="substring-before(cbc:InvoicedQuantity, '.')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="cbc:InvoicedQuantity"/>
									</xsl:otherwise>
								</xsl:choose>
							</font>
						</td>
						<!--Descripcion-->
						<td width="41%">
							<font color="#000000" size="2" face="Arial, Helvetica, sans-serif">
								<xsl:value-of select="cac:Item/cbc:Description"/> <br/>
								<xsl:call-template name="RetourneValAd"><xsl:with-param name="NumAd" select="7"/></xsl:call-template>
							</font>
						</td>
						<!--Unidad-->
						<td valign="top" align="center" width="4%">
							<font color="#000000" size="2" face="Arial, Helvetica, sans-serif">
								<xsl:call-template name="RetourneValAdItem">
									<xsl:with-param name="NumLinea" select="cbc:ID"/>
									<xsl:with-param name="NumAd" select="3"/>
								</xsl:call-template>
							</font>
						</td>
						<!--Valor Vta. Unit-->
						<td valign="top" align="right" width="7%">								
							<font color="#000000" size="2" face="Arial, Helvetica, sans-serif">
								<xsl:choose>
									<xsl:when test="string-length(substring-after(cac:Price/cbc:PriceAmount, '.')) = 3">
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after(cac:Price/cbc:PriceAmount, '.')) = 4">
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.0000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after(cac:Price/cbc:PriceAmount, '.')) = 5">
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.00000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after(cac:Price/cbc:PriceAmount, '.')) = 6">
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.000000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after(cac:Price/cbc:PriceAmount, '.')) = 7">
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.0000000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after(cac:Price/cbc:PriceAmount, '.')) = 8">
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.00000000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after(cac:Price/cbc:PriceAmount, '.')) = 9">
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.000000000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after(cac:Price/cbc:PriceAmount, '.')) = 10">
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.0000000000', 'pen')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.00', 'pen')"/>
									</xsl:otherwise>
								</xsl:choose>
							</font>
						</td>
						<!--Precio Vta. Unit-->
						<td valign="top" align="right" width="7%">
							<font color="#000000" size="2" face="Arial, Helvetica, sans-serif">
								<xsl:variable name="CTSValor1">
									<xsl:for-each select="cac:PricingReference/cac:AlternativeConditionPrice">
										<xsl:if test="cbc:PriceTypeCode = '02'">
											<xsl:value-of select="cbc:PriceAmount" />
										</xsl:if>
									</xsl:for-each>
								</xsl:variable>

								<xsl:variable name="CTSValorFinal">
									<xsl:if test="$CTSValor1 = ''">
										<xsl:value-of select="cac:PricingReference/cac:AlternativeConditionPrice/cbc:PriceAmount" />
									</xsl:if>
									<xsl:if test="$CTSValor1 != ''">
										<xsl:value-of select="$CTSValor1" />
									</xsl:if>
								</xsl:variable>

								<xsl:choose>
									<xsl:when test="string-length(substring-after($CTSValorFinal, '.')) = 3">
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after($CTSValorFinal, '.')) = 4">
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.0000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after($CTSValorFinal, '.')) = 5">
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.00000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after($CTSValorFinal, '.')) = 6">
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.000000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after($CTSValorFinal, '.')) = 7">
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.0000000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after($CTSValorFinal, '.')) = 8">
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.00000000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after($CTSValorFinal, '.')) = 9">
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.000000000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after($CTSValorFinal, '.')) = 10">
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.0000000000', 'pen')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.00', 'pen')"/>
									</xsl:otherwise>
								</xsl:choose>
							</font>
						</td>
						<!--Importe-->
						<td valign="top" align="right" width="10%">
							<font color="#000000" size="2" face="Arial, Helvetica, sans-serif">
								<xsl:value-of select="format-number(cbc:LineExtensionAmount, '###,###,##0.00', 'pen')"/>
							</font>
						</td>
					</tr>
				</xsl:for-each>

				<xsl:for-each select="/pe1:CreditNote/cac:CreditNoteLine">
					<tr>
						<!--Codigo-->
						<td valign="top" align="center" width="6%">
							<font color="#000000" size="2" face="Arial, Helvetica, sans-serif">
								<xsl:value-of select="cac:Item/cac:SellersItemIdentification/cbc:ID"/>
							</font>
						</td>
						<!--Cantidad-->
						<td valign="top" align="right" width="6%">
							<font color="#000000" size="2" face="Arial, Helvetica, sans-serif">
								<xsl:choose>
									<xsl:when test="substring-after(cbc:CreditedQuantity, '.') = '00'">
										<xsl:value-of select="substring-before(cbc:CreditedQuantity, '.')"/>
									</xsl:when>
									<xsl:when test="substring-after(cbc:CreditedQuantity, '.') = '000'">
										<xsl:value-of select="substring-before(cbc:CreditedQuantity, '.')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="cbc:CreditedQuantity"/>
									</xsl:otherwise>
								</xsl:choose>
							</font>
						</td>
						<!--Descripcion-->
						<td width="41%">
							<!-- Detalle descripción-->
							<font color="#000000" size="2" face="Arial, Helvetica, sans-serif">
								<xsl:value-of select="cac:Item/cbc:Description"/>
								<xsl:call-template name="RetourneValAd"><xsl:with-param name="NumAd" select="7"/></xsl:call-template>
							</font>
						</td>
						<!--Unidad Medida-->
						<td valign="top" align="center" width="4%">
							<font color="#000000" size="2" face="Arial, Helvetica, sans-serif">
								<xsl:call-template name="RetourneValAdItem">
									<xsl:with-param name="NumAd" select="3"/>
									<xsl:with-param name="NumLinea" select="cbc:ID"/>
								</xsl:call-template>
							</font>
						</td>
		
						<!--Valor Vta. Unit-->
						<td valign="top" align="right" width="7%">								
							<font color="#000000" size="2" face="Arial, Helvetica, sans-serif">
								<xsl:choose>
									<xsl:when test="string-length(substring-after(cac:Price/cbc:PriceAmount, '.')) = 3">
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after(cac:Price/cbc:PriceAmount, '.')) = 4">
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.0000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after(cac:Price/cbc:PriceAmount, '.')) = 5">
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.00000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after(cac:Price/cbc:PriceAmount, '.')) = 6">
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.000000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after(cac:Price/cbc:PriceAmount, '.')) = 7">
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.0000000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after(cac:Price/cbc:PriceAmount, '.')) = 8">
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.00000000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after(cac:Price/cbc:PriceAmount, '.')) = 9">
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.000000000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after(cac:Price/cbc:PriceAmount, '.')) = 10">
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.0000000000', 'pen')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.00', 'pen')"/>
									</xsl:otherwise>
								</xsl:choose>
							</font>
						</td>
<!--						Dcto. Unit
						<td valign="top" align="right" width="7%">
							<xsl:variable name="ValorAdicional2">	
								<xsl:call-template name="RetourneValAdItem">
									<xsl:with-param name="NumLinea" select="cbc:ID"/>
									<xsl:with-param name="NumAd" select="2"/>
								</xsl:call-template>
							</xsl:variable>	
							<xsl:if test="$ValorAdicional2">
								<font color="#000000" size="2" face="Arial, Helvetica, sans-serif">
									<xsl:value-of select="$ValorAdicional2"/>
								</font>
							</xsl:if>
						</td>-->
						<!--Precio Vta. Unit-->
						<td valign="top" align="right" width="7%">
							<font color="#000000" size="2" face="Arial, Helvetica, sans-serif">
								<xsl:variable name="CTSValor1">
									<xsl:for-each select="cac:PricingReference/cac:AlternativeConditionPrice">
										<xsl:if test="cbc:PriceTypeCode = '02'">
											<xsl:value-of select="cbc:PriceAmount" />
										</xsl:if>
									</xsl:for-each>
								</xsl:variable>

								<xsl:variable name="CTSValorFinal">
									<xsl:if test="$CTSValor1 = ''">
										<xsl:value-of select="cac:PricingReference/cac:AlternativeConditionPrice/cbc:PriceAmount" />
									</xsl:if>
									<xsl:if test="$CTSValor1 != ''">
										<xsl:value-of select="$CTSValor1" />
									</xsl:if>
								</xsl:variable>

								<xsl:choose>
									<xsl:when test="string-length(substring-after($CTSValorFinal, '.')) = 3">
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after($CTSValorFinal, '.')) = 4">
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.0000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after($CTSValorFinal, '.')) = 5">
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.00000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after($CTSValorFinal, '.')) = 6">
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.000000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after($CTSValorFinal, '.')) = 7">
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.0000000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after($CTSValorFinal, '.')) = 8">
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.00000000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after($CTSValorFinal, '.')) = 9">
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.000000000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after($CTSValorFinal, '.')) = 10">
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.0000000000', 'pen')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.00', 'pen')"/>
									</xsl:otherwise>
								</xsl:choose>
							</font>
						</td>
						<!--Importe-->
						<td valign="top" align="right" width="10%">
							<font color="#000000" size="2" face="Arial, Helvetica, sans-serif">
								<xsl:value-of select="format-number(cbc:LineExtensionAmount, '###,###,##0.00', 'pen')"/>
							</font>
						</td>
					</tr>
				</xsl:for-each>

				<xsl:for-each select="/pe2:DebitNote/cac:DebitNoteLine">
					<tr>
						<!--Codigo-->
						<td valign="top" align="center" width="6%">
							<font color="#000000" size="2" face="Arial, Helvetica, sans-serif">
								<xsl:value-of select="cac:Item/cac:SellersItemIdentification/cbc:ID"/>
							</font>
						</td>
						<!--Cantidad-->
						<td valign="top" align="right" width="6%">
							<font color="#000000" size="2" face="Arial, Helvetica, sans-serif">
								<xsl:choose>
									<xsl:when test="substring-after(cbc:DebitedQuantity, '.') = '00'">
										<xsl:value-of select="substring-before(cbc:DebitedQuantity, '.')"/>
									</xsl:when>
									<xsl:when test="substring-after(cbc:DebitedQuantity, '.') = '000'">
										<xsl:value-of select="substring-before(cbc:DebitedQuantity, '.')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="cbc:DebitedQuantity"/>
									</xsl:otherwise>
								</xsl:choose>
							</font>
						</td>
						<!--Descripcion-->
						<td align="left" width="41%">
							<font color="#000000" size="2" face="Arial, Helvetica, sans-serif">
								<xsl:value-of select="cac:Item/cbc:Description"/><br/>
								<xsl:call-template name="RetourneValAd"><xsl:with-param name="NumAd" select="7"/></xsl:call-template>
							</font>
						</td>
						<!--Unidad Medida-->
						<td valign="top" align="center" width="4%">
							<font color="#000000" size="2" face="Arial, Helvetica, sans-serif">
								<xsl:call-template name="RetourneValAdItem">
									<xsl:with-param name="NumLinea" select="cbc:ID"/>
									<xsl:with-param name="NumAd" select="3"/>
								</xsl:call-template>
							</font>
						</td>
						<!--Valor Vta. Unit-->
						<td valign="top" align="right" width="7%">								
							<font color="#000000" size="2" face="Arial, Helvetica, sans-serif">
								<xsl:choose>
									<xsl:when test="string-length(substring-after(cac:Price/cbc:PriceAmount, '.')) = 3">
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after(cac:Price/cbc:PriceAmount, '.')) = 4">
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.0000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after(cac:Price/cbc:PriceAmount, '.')) = 5">
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.00000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after(cac:Price/cbc:PriceAmount, '.')) = 6">
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.000000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after(cac:Price/cbc:PriceAmount, '.')) = 7">
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.0000000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after(cac:Price/cbc:PriceAmount, '.')) = 8">
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.00000000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after(cac:Price/cbc:PriceAmount, '.')) = 9">
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.000000000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after(cac:Price/cbc:PriceAmount, '.')) = 10">
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.0000000000', 'pen')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '###,###,##0.00', 'pen')"/>
									</xsl:otherwise>
								</xsl:choose>
							</font>
						</td>
						<!--Precio Vta. Unit-->
						<td valign="top" align="right" width="7%">
							<font color="#000000" size="2" face="Arial, Helvetica, sans-serif">
								<xsl:variable name="CTSValor1">
									<xsl:for-each select="cac:PricingReference/cac:AlternativeConditionPrice">
										<xsl:if test="cbc:PriceTypeCode = '02'">
											<xsl:value-of select="cbc:PriceAmount" />
										</xsl:if>
									</xsl:for-each>
								</xsl:variable>

								<xsl:variable name="CTSValorFinal">
									<xsl:if test="$CTSValor1 = ''">
										<xsl:value-of select="cac:PricingReference/cac:AlternativeConditionPrice/cbc:PriceAmount" />
									</xsl:if>
									<xsl:if test="$CTSValor1 != ''">
										<xsl:value-of select="$CTSValor1" />
									</xsl:if>
								</xsl:variable>

								<xsl:choose>
									<xsl:when test="string-length(substring-after($CTSValorFinal, '.')) = 3">
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after($CTSValorFinal, '.')) = 4">
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.0000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after($CTSValorFinal, '.')) = 5">
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.00000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after($CTSValorFinal, '.')) = 6">
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.000000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after($CTSValorFinal, '.')) = 7">
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.0000000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after($CTSValorFinal, '.')) = 8">
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.00000000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after($CTSValorFinal, '.')) = 9">
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.000000000', 'pen')"/>
									</xsl:when>
									<xsl:when test="string-length(substring-after($CTSValorFinal, '.')) = 10">
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.0000000000', 'pen')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="format-number($CTSValorFinal, '###,###,##0.00', 'pen')"/>
									</xsl:otherwise>
								</xsl:choose>
							</font>
						</td>
						<!--Importe-->
						<td valign="top" align="right" width="10%">
							<font color="#000000" size="2" face="Arial, Helvetica, sans-serif">
								<xsl:value-of select="format-number(cbc:LineExtensionAmount, '###,###,##0.00', 'pen')"/>
							</font>
						</td>
					</tr>
				</xsl:for-each>

				<xsl:call-template name="lineaBl"><xsl:with-param name="cont" select="$numColBl"/></xsl:call-template>
			</tbody>
		</table>
	</xsl:template>

	<xsl:template name="lineaBl">
		<xsl:param name="cont"/>
		<xsl:if test="$cont &gt; 0">
			<tr>
				<td><xsl:text>&#160;</xsl:text></td>
				<td/>
				<td/>
				<td/>
				<td/>
				<td/>
				<td/>			
			</tr>
			<xsl:call-template name="lineaBl">
				<xsl:with-param name="cont" select="$cont - 1"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template name="RetourneValAdItem">
		<xsl:param name="NumLinea"/>
		<xsl:param name="NumAd"/>

		<xsl:for-each select="//ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/pe:DatosAdicionales/pe:LineaDetalle">
			<xsl:if test="pe:Codigo = concat($NumLinea, $NumAd)">
				<xsl:value-of select="pe:Valor"/>
			</xsl:if>
		</xsl:for-each>
		<xsl:for-each select="//ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/pe1:DatosAdicionales/pe1:LineaDetalle">
			<xsl:if test="pe1:Codigo = concat($NumLinea, $NumAd)">
				<xsl:value-of select="pe1:Valor"/>
			</xsl:if>
		</xsl:for-each>
		<xsl:for-each select="//ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/pe2:DatosAdicionales/pe2:LineaDetalle">
			<xsl:if test="pe2:Codigo = concat($NumLinea, $NumAd)">
				<xsl:value-of select="pe2:Valor"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="replace-string">
		<xsl:param name="str"/>
		<xsl:param name="strToReplace"/>
		<!--<xsl:param name="newStr"/>-->

		<xsl:if test="string-length(substring-before($str, $strToReplace)) = 0">
			<xsl:value-of select="$str"/>
		</xsl:if>
		<xsl:if test="string-length(substring-before($str, $strToReplace)) > 0">
			<xsl:value-of select="substring-before($str, $strToReplace)"/>
			<br/>
		</xsl:if>
		<xsl:if test="string-length(substring-after($str, $strToReplace)) > 0">
			<xsl:call-template name="replace-string">
				<xsl:with-param name="str" select="substring-after($str, $strToReplace)"/>
				<xsl:with-param name="strToReplace" select="$strToReplace"/>
				<!--<xsl:with-param name="newStr" select="$newStr"/>-->
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template name="replace-string2">
	    <xsl:param name="string"/>
	    <xsl:param name="replace"/>
	    <xsl:param name="with"/>
	    <xsl:choose>
	        <xsl:when test="contains($string, $replace)">
	            <xsl:value-of select="substring-before($string, $replace)"/>
	            <xsl:value-of select="$with"/>
	            <xsl:call-template name="replace-string2">
	                <xsl:with-param name="string" select="substring-after($string,$replace)"/>
	                <xsl:with-param name="replace" select="$replace"/>
	                <xsl:with-param name="with" select="$with"/>
	            </xsl:call-template>
	        </xsl:when>
	        <xsl:otherwise>
	            <xsl:value-of select="$string"/>
	        </xsl:otherwise>
	    </xsl:choose>
	</xsl:template>

	<xsl:template name="RenvoyerChaineIndice1">
		<xsl:param name="Chaine"/>
		<xsl:value-of select="substring-before($Chaine, '|')"/>
	</xsl:template>
		
	<xsl:template name="RenvoyerChaineIndice2">
		<xsl:param name="Chaine"/>
		<xsl:variable name="Temp1" select="substring-after($Chaine, '|')"/>
		<xsl:value-of select="substring-before($Temp1, '|')"/>
	</xsl:template>

	<xsl:template name="RenvoyerChaineIndice3">
		<xsl:param name="Chaine"/>
		<xsl:variable name="Temp1" select="substring-after($Chaine, '|')"/>
		<xsl:variable name="Temp2" select="substring-after($Temp1, '|')"/>
		<xsl:value-of select="substring-before($Temp2, '|')"/>
	</xsl:template>

	<xsl:template name="RenvoyerChaineIndice4">
		<xsl:param name="Chaine"/>
		<xsl:variable name="Temp1" select="substring-after($Chaine, '|')"/>
		<xsl:variable name="Temp2" select="substring-after($Temp1, '|')"/>
		<xsl:variable name="Temp3" select="substring-after($Temp2, '|')"/>
		<xsl:value-of select="substring-before($Temp3, '|')"/>
	</xsl:template>
	
	<xsl:template name="RenvoyerChaineIndice5">
		<xsl:param name="Chaine"/>
		<xsl:variable name="Temp1" select="substring-after($Chaine, '|')"/>
		<xsl:variable name="Temp2" select="substring-after($Temp1, '|')"/>
		<xsl:variable name="Temp3" select="substring-after($Temp2, '|')"/>
		<xsl:variable name="Temp4" select="substring-after($Temp3, '|')"/>
		<xsl:value-of select="substring-before($Temp4, '|')"/>
	</xsl:template>
</xsl:stylesheet>
