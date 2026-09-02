@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VENDOR Ageing Final Sum'
@Metadata.ignorePropagatedAnnotations: true
define view entity   ZI_VEND_AGE_FIN_SUM_N 
  with parameters
    P_Date : datum
  as select from I_OperationalAcctgDocItem
{
  key InvoiceReference,
  key InvoiceItemReference,
  key InvoiceReferenceFiscalYear,
  key CompanyCode,
      //  key FiscalYear,
      CompanyCodeCurrency,
      Supplier,
      @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
      sum(AmountInCompanyCodeCurrency) as received
}
where
  PostingDate < $parameters.P_Date
//  ClearingJournalEntry = ''

group by
  InvoiceReference,
  CompanyCode,
  InvoiceItemReference,
  InvoiceReferenceFiscalYear,
  CompanyCodeCurrency,
  Supplier
