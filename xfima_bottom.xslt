<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
	xmlns:pe="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
	xmlns:pe1="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2"
	xmlns:pe2="urn:oasis:names:specification:ubl:schema:xsd:DebitNote-2"
	xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
	xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
	xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2">

	<xsl:template name="Referencia">
		<table border="0" cellSpacing="0" borderColor="#000000" cellPadding="0" width="100%">
			<xsl:if test="/pe1:CreditNote or /pe2:DebitNote">
				<tr>
					<td width="100%" align="left">
						<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
							<br/>
							<strong>DATOS(S) DE REFERENCIA:</strong>
							<br/>
						</font>
					</td>
				</tr>
				<tr>
					<td>
						<table border="1" cellSpacing="0" borderColor="#000000" cellPadding="0" width="30%">
							<tr>
								<td widtth="20%" align="center">
									<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
										<strong>TIPO DE DOCUMENTO</strong>
									</font>
								</td>
								<td width="20%" align="center">
									<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
										<strong>SERIE</strong>
									</font>
								</td>
								<td width="40%" align="center">
									<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
										<strong>CORRELATIVO(S)</strong>
									</font>
								</td>
								<td width="40%" align="center">
									<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
										<strong>FECHA(S)</strong>
									</font>
								</td>
							</tr>
							<tr>
								<td width="20%" align="center">
		                          	<font face="Arial, Helvetica, sans-serif" size="1">
										<xsl:variable name="CTSTipoCPE">
											<xsl:for-each select="//cac:BillingReference/cac:InvoiceDocumentReference">
		                						<xsl:if test="cbc:DocumentTypeCode != '10'">
													<xsl:choose>
			                                        	<xsl:when test="cbc:DocumentTypeCode = '01'">FACTURA*</xsl:when>
			                                        	<xsl:when test="cbc:DocumentTypeCode = '03'">BOLETA*</xsl:when>
			                                        	<xsl:when test="cbc:DocumentTypeCode = '07'">NOTA DE CRÉDITO*</xsl:when>
			                                        	<xsl:when test="cbc:DocumentTypeCode = '08'">NOTA DE DÉBITO*</xsl:when>
			                                        	<xsl:otherwise>Documento NN</xsl:otherwise>
			                                     	</xsl:choose>
												</xsl:if>
											</xsl:for-each>
										</xsl:variable>
										<xsl:value-of select="substring-before($CTSTipoCPE, '*')"/>
		                        	</font>
		                		</td>
		                 		<td width="20%" align="left">
		                    		<font face="Arial, Helvetica, sans-serif" size="1">
										<xsl:for-each select="//cac:BillingReference/cac:InvoiceDocumentReference">
			                					<xsl:if test="cbc:DocumentTypeCode != '10'">
													<xsl:value-of select="substring-before(cbc:ID, '-')"/>
												</xsl:if>
										</xsl:for-each>
		                    		</font>
		                 		</td>
								<td width="20%" align="right" >
									<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
											<xsl:for-each select="//cac:BillingReference/cac:InvoiceDocumentReference">
			                					<xsl:if test="cbc:DocumentTypeCode != '10'">
													<xsl:value-of select="substring-after(cbc:ID, '-')"/>
												</xsl:if>
											</xsl:for-each>
									</font>
								</td>
								<td>
									<xsl:call-template name="RetourneValAd">
										<xsl:with-param name="NumAd" select="14"/>
									</xsl:call-template>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td width="100%" align="left">
						<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
						<strong>MOTIVO:</strong> <br/>
							<xsl:value-of select="//cac:DiscrepancyResponse/cbc:Description"/>
						</font>
					</td>
				</tr>
			</xsl:if>
		</table>
	</xsl:template>

	<xsl:template name="bottom_hash">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td>
					&#160;
				</td>
			</tr>
			<tr>
				<td>
					&#160;
				</td>
			</tr>
			<tr>
				<td>
					<table border="0" cellSpacing="0" borderColor="#000000" cellPadding="0" width="100%">
						<tr>
							<td valign="baseline" align="center" width="50%">
								<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
									Representación impresa de la
									<xsl:choose>
										<xsl:when test="/pe:Invoice/cbc:InvoiceTypeCode = '01'">Factura Electrónica</xsl:when>
										<xsl:when test="/pe:Invoice/cbc:InvoiceTypeCode = '03'">Boleta de Venta Electrónica</xsl:when>
										<xsl:when test="/pe1:CreditNote">Nota de Crédito Electrónica</xsl:when>
										<xsl:when test="/pe2:DebitNote">Nota de Dédito Electrónica</xsl:when>
										<xsl:otherwise></xsl:otherwise>
									</xsl:choose>
									<br/>Podrá ser consultada en:www.fima.com.pe							
									<br/>Autorizado mediante Resolución de Intendencia N.° 0180050001175/SUNAT
								</font>
							</td>				
						</tr>
						<tr>
							<td align="center" width="50%">
								<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
									<img><xsl:attribute name="src"><xsl:call-template name="timbre"/></xsl:attribute></img>
								</font>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="timbre">
		<xsl:call-template name="nombreTed">
			<xsl:with-param name="text" select="//cac:AccountingSupplierParty/cbc:CustomerAssignedAccountID"/>
			<xsl:with-param name="largo" select="'11'"/>
		</xsl:call-template>
		<xsl:value-of select="'-'"/>
		<xsl:value-of select="//cbc:InvoiceTypeCode"/>
		<xsl:if test="/pe1:CreditNote">
			<xsl:value-of select="'07'"/>
		</xsl:if>
		<xsl:if test="/pe2:DebitNote">
			<xsl:value-of select="'08'"/>
		</xsl:if>
		<xsl:value-of select="'-'"/>
		<xsl:value-of select="/pe:Invoice/cbc:ID"/>
		<xsl:value-of select="/pe1:CreditNote/cbc:ID"/>
		<xsl:value-of select="/pe2:DebitNote/cbc:ID"/>
		<xsl:value-of select="'.jpg'"/>
	</xsl:template>

	<xsl:template name="nombreTed">
		<xsl:param name="text"/>
		<xsl:param name="largo" select="0"/>
		<xsl:variable name="largo_actual" select="string-length($text)"/>
		
		<xsl:choose>
			<xsl:when test="$largo_actual >= $largo">
				<xsl:value-of select="$text"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="prefix" select="concat('0', $text)"/>
				<xsl:call-template name="nombreTed">
					<xsl:with-param name="text" select="$prefix"/>
					<xsl:with-param name="largo" select="$largo"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
