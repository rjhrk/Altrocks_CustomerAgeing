@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'REMOVE L'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_VEND_AGEING_RL_N
  with parameters
    P_Date : datum
  as select from ZI_VEND_AGEING_SUM_N  (    P_Date: $parameters.P_Date )
{
  key InvoiceReference,
  key InvoiceItemReference,
  key InvoiceReferenceFiscalYear,
  key CompanyCode,
      CompanyCodeCurrency,  
      SUPPLIER,
      @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
      sum(AmountInCompanyCodeCurrency) as received

}
where
  Symbol <> 'L'
group by
  InvoiceReference,
  CompanyCode,
  InvoiceItemReference,
  InvoiceReferenceFiscalYear,
  CompanyCodeCurrency,
  SUPPLIER           
