RSpec.describe GS1::AI do
  describe 'SSCC' do
    subject { described_class::SSCC }

    it { is_expected.to eq('00') }
  end

  describe 'GTIN' do
    subject { described_class::GTIN }

    it { is_expected.to eq('01') }
  end

  describe 'CONTENT' do
    subject { described_class::CONTENT }

    it { is_expected.to eq('02') }
  end

  describe 'BATCH_LOT' do
    subject { described_class::BATCH_LOT }

    it { is_expected.to eq('10') }
  end

  describe 'PROD_DATE' do
    subject { described_class::PROD_DATE }

    it { is_expected.to eq('11') }
  end

  describe 'DUE_DATE' do
    subject { described_class::DUE_DATE }

    it { is_expected.to eq('12') }
  end

  describe 'PACK_DATE' do
    subject { described_class::PACK_DATE }

    it { is_expected.to eq('13') }
  end

  describe 'BEST_BY' do
    subject { described_class::BEST_BY }

    it { is_expected.to eq('15') }
  end

  describe 'SELL_BY' do
    subject { described_class::SELL_BY }

    it { is_expected.to eq('16') }
  end

  describe 'USE_BY' do
    subject { described_class::USE_BY }

    it { is_expected.to eq('17') }
  end

  describe 'VARIANT' do
    subject { described_class::VARIANT }

    it { is_expected.to eq('20') }
  end

  describe 'SERIAL' do
    subject { described_class::SERIAL }

    it { is_expected.to eq('21') }
  end

  describe 'CPV' do
    subject { described_class::CPV }

    it { is_expected.to eq('22') }
  end

  describe 'ADDITIONAL_ID' do
    subject { described_class::ADDITIONAL_ID }

    it { is_expected.to eq('240') }
  end

  describe 'CUST_PART_NO' do
    subject { described_class::CUST_PART_NO }

    it { is_expected.to eq('241') }
  end

  describe 'MTO_VARIANT' do
    subject { described_class::MTO_VARIANT }

    it { is_expected.to eq('242') }
  end

  describe 'PCN' do
    subject { described_class::PCN }

    it { is_expected.to eq('243') }
  end

  describe 'SECONDARY_SERIAL' do
    subject { described_class::SECONDARY_SERIAL }

    it { is_expected.to eq('250') }
  end

  describe 'REF_TO_SOURCE' do
    subject { described_class::REF_TO_SOURCE }

    it { is_expected.to eq('251') }
  end

  describe 'GDTI' do
    subject { described_class::GDTI }

    it { is_expected.to eq('253') }
  end

  describe 'GLN_EXTENSION_COMPONENT' do
    subject { described_class::GLN_EXTENSION_COMPONENT }

    it { is_expected.to eq('254') }
  end

  describe 'GCN' do
    subject { described_class::GCN }

    it { is_expected.to eq('255') }
  end

  describe 'VAR_COUNT' do
    subject { described_class::VAR_COUNT }

    it { is_expected.to eq('30') }
  end

  describe 'ORDER_NUMBER' do
    subject { described_class::ORDER_NUMBER }

    it { is_expected.to eq('400') }
  end

  describe 'GINC' do
    subject { described_class::GINC }

    it { is_expected.to eq('401') }
  end

  describe 'GSIN' do
    subject { described_class::GSIN }

    it { is_expected.to eq('402') }
  end

  describe 'ROUTE' do
    subject { described_class::ROUTE }

    it { is_expected.to eq('403') }
  end

  describe 'SHIP_TO_LOC' do
    subject { described_class::SHIP_TO_LOC }

    it { is_expected.to eq('410') }
  end

  describe 'BILL_TO' do
    subject { described_class::BILL_TO }

    it { is_expected.to eq('411') }
  end

  describe 'PURCHASE_FROM' do
    subject { described_class::PURCHASE_FROM }

    it { is_expected.to eq('412') }
  end

  describe 'SHIP_FOR_LOC' do
    subject { described_class::SHIP_FOR_LOC }

    it { is_expected.to eq('413') }
  end

  describe 'LOC_NO' do
    subject { described_class::LOC_NO }

    it { is_expected.to eq('414') }
  end

  describe 'PAY_TO' do
    subject { described_class::PAY_TO }

    it { is_expected.to eq('415') }
  end

  describe 'PROD_SERV_LOC' do
    subject { described_class::PROD_SERV_LOC }

    it { is_expected.to eq('416') }
  end

  describe 'SHIP_TO_POST' do
    subject { described_class::SHIP_TO_POST }

    it { is_expected.to eq('420') }
  end

  describe 'SHIP_TO_POST_ISO' do
    subject { described_class::SHIP_TO_POST_ISO }

    it { is_expected.to eq('421') }
  end

  describe 'ORIGIN' do
    subject { described_class::ORIGIN }

    it { is_expected.to eq('422') }
  end

  describe 'COUNTRY_INITIAL_PROCESS' do
    subject { described_class::COUNTRY_INITIAL_PROCESS }

    it { is_expected.to eq('423') }
  end

  describe 'COUNTRY_PROCESS' do
    subject { described_class::COUNTRY_PROCESS }

    it { is_expected.to eq('424') }
  end

  describe 'COUNTRY_DISASSEMBLY' do
    subject { described_class::COUNTRY_DISASSEMBLY }

    it { is_expected.to eq('425') }
  end

  describe 'COUNTRY_FULL_PROCESS' do
    subject { described_class::COUNTRY_FULL_PROCESS }

    it { is_expected.to eq('426') }
  end

  describe 'ORIGIN_SUBDIVISION' do
    subject { described_class::ORIGIN_SUBDIVISION }

    it { is_expected.to eq('427') }
  end

  describe 'NSN' do
    subject { described_class::NSN }

    it { is_expected.to eq('7001') }
  end

  describe 'MEAT_CUT' do
    subject { described_class::MEAT_CUT }

    it { is_expected.to eq('7002') }
  end

  describe 'EXPIRY_TIME' do
    subject { described_class::EXPIRY_TIME }

    it { is_expected.to eq('7003') }
  end

  describe 'ACTIVE_POTENCY' do
    subject { described_class::ACTIVE_POTENCY }

    it { is_expected.to eq('7004') }
  end

  describe 'CATCH_AREA' do
    subject { described_class::CATCH_AREA }

    it { is_expected.to eq('7005') }
  end

  describe 'FIRST_FREEZE_DATE' do
    subject { described_class::FIRST_FREEZE_DATE }

    it { is_expected.to eq('7006') }
  end

  describe 'HARVEST_DATE' do
    subject { described_class::HARVEST_DATE }

    it { is_expected.to eq('7007') }
  end

  describe 'AQUATIC_SPECIES' do
    subject { described_class::AQUATIC_SPECIES }

    it { is_expected.to eq('7008') }
  end

  describe 'FISHING_GEAR_TYPE' do
    subject { described_class::FISHING_GEAR_TYPE }

    it { is_expected.to eq('7009') }
  end

  describe 'PROD_METHOD' do
    subject { described_class::PROD_METHOD }

    it { is_expected.to eq('7010') }
  end

  describe 'REFURB_LOT' do
    subject { described_class::REFURB_LOT }

    it { is_expected.to eq('7020') }
  end

  describe 'FUNC_STAT' do
    subject { described_class::FUNC_STAT }

    it { is_expected.to eq('7021') }
  end

  describe 'REV_STAT' do
    subject { described_class::REV_STAT }

    it { is_expected.to eq('7022') }
  end

  describe 'GIAI_ASSEMBLY' do
    subject { described_class::GIAI_ASSEMBLY }

    it { is_expected.to eq('7023') }
  end

  describe 'PROCESSOR' do
    subject { described_class::PROCESSOR }

    it { is_expected.to eq('703') }
  end

  describe 'DIMENSIONS' do
    subject { described_class::DIMENSIONS }

    it { is_expected.to eq('8001') }
  end

  describe 'CMT_NO' do
    subject { described_class::CMT_NO }

    it { is_expected.to eq('8002') }
  end

  describe 'GRAI' do
    subject { described_class::GRAI }

    it { is_expected.to eq('8003') }
  end

  describe 'GIAI' do
    subject { described_class::GIAI }

    it { is_expected.to eq('8004') }
  end

  describe 'PRICE_PER_UNIT' do
    subject { described_class::PRICE_PER_UNIT }

    it { is_expected.to eq('8005') }
  end

  describe 'GCTIN' do
    subject { described_class::GCTIN }

    it { is_expected.to eq('8006') }
  end

  describe 'IBAN' do
    subject { described_class::IBAN }

    it { is_expected.to eq('8007') }
  end

  describe 'PROD_TIME' do
    subject { described_class::PROD_TIME }

    it { is_expected.to eq('8008') }
  end

  describe 'CPID' do
    subject { described_class::CPID }

    it { is_expected.to eq('8010') }
  end

  describe 'CPID_SERIAL' do
    subject { described_class::CPID_SERIAL }

    it { is_expected.to eq('8011') }
  end

  describe 'VERSION' do
    subject { described_class::VERSION }

    it { is_expected.to eq('8012') }
  end

  describe 'GMN' do
    subject { described_class::GMN }

    it { is_expected.to eq('8013') }
  end

  describe 'GSRN_PROVIDER' do
    subject { described_class::GSRN_PROVIDER }

    it { is_expected.to eq('8017') }
  end

  describe 'GSRN_RECIPIENT' do
    subject { described_class::GSRN_RECIPIENT }

    it { is_expected.to eq('8018') }
  end

  describe 'SRIN' do
    subject { described_class::SRIN }

    it { is_expected.to eq('8019') }
  end

  describe 'REF_NO' do
    subject { described_class::REF_NO }

    it { is_expected.to eq('8020') }
  end

  describe 'COUPON_CODE' do
    subject { described_class::COUPON_CODE }

    it { is_expected.to eq('8110') }
  end

  describe 'POINTS' do
    subject { described_class::POINTS }

    it { is_expected.to eq('8111') }
  end

  describe 'PRODUCT_URL' do
    subject { described_class::PRODUCT_URL }

    it { is_expected.to eq('8200') }
  end

  describe 'INTERNAL' do
    subject { described_class::INTERNAL }

    it { is_expected.to eq('90') }
  end

  describe 'INTERNAL1' do
    subject { described_class::INTERNAL1 }

    it { is_expected.to eq('91') }
  end

  describe 'INTERNAL2' do
    subject { described_class::INTERNAL2 }

    it { is_expected.to eq('92') }
  end

  describe 'INTERNAL3' do
    subject { described_class::INTERNAL3 }

    it { is_expected.to eq('93') }
  end

  describe 'INTERNAL4' do
    subject { described_class::INTERNAL4 }

    it { is_expected.to eq('94') }
  end

  describe 'INTERNAL5' do
    subject { described_class::INTERNAL5 }

    it { is_expected.to eq('95') }
  end

  describe 'INTERNAL6' do
    subject { described_class::INTERNAL6 }

    it { is_expected.to eq('96') }
  end

  describe 'INTERNAL7' do
    subject { described_class::INTERNAL7 }

    it { is_expected.to eq('97') }
  end

  describe 'INTERNAL8' do
    subject { described_class::INTERNAL8 }

    it { is_expected.to eq('98') }
  end

  describe 'INTERNAL9' do
    subject { described_class::INTERNAL9 }

    it { is_expected.to eq('99') }
  end
end
