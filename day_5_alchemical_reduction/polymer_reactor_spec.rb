require 'rspec'
require 'pry'
require_relative 'polymer_reactor.rb'

RSpec.describe PolymerReactor do
  subject { PolymerReactor.new(polymer: polymer) }
  let(:class_subject) { described_class.select_best_removed_unit_type(polymer: polymer) }
  let(:file_polymer) { File.read('polymer_input.txt').gsub('\n', '').chomp }

  describe '.select_best_removed_unit_type' do
    context "when polymer is 'dabAcCaCBAcCcaDA'" do
      let(:polymer) { 'dabAcCaCBAcCcaDA' }

      it 'returns 4' do
        expect(class_subject).to eq 4
      end
    end

    context "when polymer is file input" do
      let(:polymer) { file_polymer }

      it 'returns 6484' do
        expect(class_subject).to eq 6484
      end
    end
  end

  describe '#react_polymer' do
    context "when polymer is 'aA'" do
      let(:polymer) { 'aA' }

      it 'returns an empty string' do
        expect(subject.react_polymer).to eq ''
      end
    end

    context "when polymer is 'abBA'" do
      let(:polymer) { 'abBA' }

      it 'returns an empty string' do
        expect(subject.react_polymer).to eq ''
      end
    end

    context "when polymer is 'abAB'" do
      let(:polymer) { 'abAB' }

      it 'returns "abAB"' do
        expect(subject.react_polymer).to eq 'abAB'
      end
    end

    context "when polymer is 'aabAAB'" do
      let(:polymer) { 'aabAAB' }

      it 'returns "aabAAB"' do
        expect(subject.react_polymer).to eq 'aabAAB'
      end
    end

    context "when polymer is 'dabAcCaCBAcCcaDA'" do
      let(:polymer) { 'dabAcCaCBAcCcaDA' }

      it 'returns "dabCBAcaDA"' do
        expect(subject.react_polymer).to eq 'dabCBAcaDA'
      end
    end

    context "when polymer is file input" do
      let(:polymer) { file_polymer }

      it 'returns the full reacted polymer' do
        result = subject.react_polymer
        expect(result).to eq 'lXOFifLmfbmvsxtzTKBkillsEJgfvBMNmEyksjICnCNYOxbWZFSMWVLiwixTlQEQrleuDLjvBNkDCqwmZrqhoQnvWEoNwAQEWUnJfpzfYVWJqrmSYnqhNyWxIYjiMjdQJsVLEXuFxyhPWLQAPongydxxzARkbFkiEQhKmGYnhwNXVCEAYghwTCIRdQayAVoUKeCKydncaNUTuQLQzdjqgZawIODzhsKDScnZkUAGKjNwcPhpRwYILMjQKKPDJSfLakkVhOiKvoKzCYfNiqnoLYcqlsnzdLrYJbQDMABiJiTCHBAYLjLmgDoicLqSatHNRvechhJRxnaIULdmVVobgsxgrMCzYtqGSYKovJVOmFHmpVshAhEPXKyirOibqyMuJCREOTpguNLxMGSAuHFWiyJyOrLYQDZJhyMNOisYGNrPVzYmmuQAwmCRPXkpzYROQrXkRAKmXMgPFykowlnOhZAFRgoBwmSdxgrvvvkFZpSULqAqKOYunEIHSijAfEBvDLglcylsRDhWcYIReUttCsisAvEgEtcjvHEbEDVznZXmCbuRBNFjeugZmRzRBXsVrXIrHxELFsgWvKcNtpLWCufgQMacyHUYBtKCeULEczzXiFZLhCLoYuWYYctgbgNbrLqNFXJzLiaOHIRemSblnqlMymABEUxDmFJImTVgRmlRtaREBzcZDheMJHamGSOvgpGYSTpfeenfhJLLWSicuGduBGCuxunDvFPcZRLIHxpywKpuWvWEEHXaLnCvpUBrmtXihmuXFQUZBkwRxPsPdCVFxAqYRIoPmGjOHwkDgPsOOXfkcfUnduVPkFWNcUhxbLOIdvnCAGKqORUzdZApgVaKEcmazSZoSlgeMWyvvgMEgkWDZMCezoLhejcLBWVjCsxnkFRAuxStpRQchpqSQgyxMuqzAHypgeIAyoxcqXYJHvpbZVJRRTSCdANiJBXaulsJbkNjmivjUSMhTrBnsVaKGiVqYtAykIjGCsfKDqjzmqcRSVNKSPtWqcxpNPiLEHTNrAXudVNiGWDLxQbSqPMHuFOZCiOzmZDTIsTjYvvXvRaoXHBGXGIbWBMpKZFULuDvbpVJAFUcAnBNhLjtFobzHAkGaojSYupVpnyVwfSqxtMZrPcmrKlOcBOLaOWEAyKgBlcwmrcoRAmWUJSbwvxVzqjaljHGaGhqlQCwtJZhTjMWNkXOetNhEtBwNiHeaOuxrCQcZabUjMXfQSbKcdyCuWBBsVunRjEHAfIxWkDDwyixidCiJlUAmsKVghscnPQvMMbvorNgzohwvtOyBCBOWmESVuMAmAPZiqtmiqrFeKfrytnBpgsDtYlwPzumJhysmJGhTGYEiLsXMeDURzLmSBBLOkxDBHSakpNKdysvkqAhXfVOTkGwfNuOalEAPtzwqxUmaEuRZmpeqByXDflXbiYYOLKDASTZEispBpHrNYpAENpoHcoYufNdgJBHsyMvTMVNOcMayjnqSVcHsukDFLedgvwVMrwJdbfPOLgOsrsqVchkeKyTugYXfRkySGklhZPaFMKnQzDZWoQxhWUgylKafqOcuDhVKGduORoKoChpYxMPYtdasXHYDSupAlBJFMfcIlYkLhaNSYfhwkQhtKfWTQMJVAbwlrIqBGkJyPATpYYtDmYIDAgQTYmBHOtbTfDgSXVBjGZaNGvgvGzqHmPdxKDizIaiCkRtBaSTwXwYGwYTBPojPFhuOvRcJElZwpcYNtMwyseBoQZZflvupSScJuWDtrwmqoEQwEvwzcqtpLoapyNdzSenwXUFOMbSfbvenVKREQIJREGvaaNYmYUOzNEFvNYLmuRATEXNPAGwfnaYmhYqRAsgrUXqLfGySqbSzBSbmKxqrqhppyejxQuCAbREhfoHEXpnFlXMxrmEUFboKIgrMeWXgsVGVpzMIQRftptDNDwOQdiizBDHUqVhEmUWLgvyAMdGbsEqMSjFEzQglIqurxgVHltXsubKfWAJAmwBuMahrujoEQyaKzAxMTWcAeoospZWrTrdVGJhVJXkNtKSYdqUelqtwvvkxaTJPLraqFzmATEcbuFvHCWFBVrUHeBabaalyqudLJRQfkcFKpXQxHlRWyDOeoqZQWaUWxrEdwxCXnvegDMPSzIaLbmrZbLsPfUHlOfrhVSuyuriEuEuOYqDHoXqnlqfnVDIvJrwvaSVuxfaeMlodLmuXfLqkhFtrPJniFyespnAxGxqLRxqEbGzhSpQRQZyEmbQIqLWPHEYsngnbIDLAAPxzarJfdtDhhLUtvktgETVVtRmBiDpNPlBSyeSgstjDLdxWVRYkBKSHHyfvoQEaGKSJJxLASaoWZKgPETUfMAGFDUkFbgMeSzCPcXSUplNLrUbcIaBIUzPIPzobfsxMOOKAxjWfThTxlJxPcJlrCzcJKeANjvupZVTXmzaIsBZAIurQlhjMOkQVUzVyhLqwguxyhNWukHcnytNPvAyhxWYPIWTmvBZLYFaWrghSLuMSNTxucRGsdFwxOrXnUsyFOtFNrlzDYfJIfUemPPskgkmuhCFKAobtMqvjTMIWbjnSYklSWCtXJJnWfviWqFwitqVHlcFGScDvklUdkSTVtAgjBhSlPoxyJvuSSXVyjPiPXrTfhRsLuHosGCwvpEOyzifIpWSedRLWsglCZDSBMEvORyQeYMylplWPLhsFRNPqXCBfwwkLQePXbqfZUoVpunYPTVWypVPOcXHzhszLqNedvWjRUMgtJPiuXmBKJeWeNViCnbZPKPgzFCCOYrvJxKFNjttzRfSWgCwzWNoUBcUvBzOYExmvrgHplIFjRbIswOffpcLEDNBrgznAqEKcwDrOiVywdslcGLQlgPKQRkwEodGzgwJUZIOqjZnmvWvzugdKUpFhZIbarGmQBMdYThfxqTaWQsfNIvqCIdVyFdhEQzgxYLCdtRsQBGnjhglHJfKAgHGQlVMhffiCWzlZGviuewAElZjKOWkGBIGQLqwITXwGSwdJuCPlDGemazphNEkiLZZWnctLWCIGhRYOhddlfxiUSMajjNmFubHuOgBTTXAYzLfhCVFemCqKtwXwwucipEitNeSAgrNOPSTdqHQNibotqwQCKIavjQbmGMSaghviTxjyBxpKrGkWOycsoojbWxqEdRzfbMaoHjMEmteibXpIzIOdEZhwubaMUavIAXYHOMOaICkBZSAXkbbMWxDtfzVEImGrvkwDmmAXIPzGuVxDQHiORcmpRIySYhYzcpyJcYaZnyWqfOMIGqaxBaFxtnHXYPPwaaypNeWWrPoyLNEcixdVLIJyRpfvAVCKUGmWkhxvLSUShEstXbHVqmsruxgMcTTvOIcKfXSWOesdbvHVIPoPtyRdkqCmydqdWziuqIukOUwtWVcMgdqfRanpKupUKdgOlRywNxYCXYxVTAdyVcqIIvuaqupRkpTrTGpKjaOJpUADsNHErmCygigYZuLZQkuZxSunzdCgNtQuqrlIfdBPTmHUNRoQGIzMBsOGjRFJPTiDAmCFkjERptKtwbPblncccodWDJUszHMpmoNVhTDOyxSGvEzBYKeOyyqysProSzsgZRdhfsHxyOLxRVdciVynurgZilCsuHZooXpAewlINJvJqkRRuVoGJHgwngIJnaFsiFacBKmBJqNWtxmiSAbIqdyynHAQCBOgLZAKMAwDaxIznoFJpabURJYVGEYGRyRnurTjIYKHkrtUHxsYUfjisZImEiHAJnEpVRHoyEGJwMPHSBenOhJoydCiigbZSlYAClVPXaLrTFjwtltDliRuuYVdYtUQaHBwiJmLiZxnVfBXHNWhSbjjAjUsndyXCCsAHmrJHzHevmixWXUkJLwxpZrhbZLNdEauXLnsjaeBnwGzmTSNgkFyJTvUWUcnQfceWGrNxQNknXVaXDJkiTuVEsEwsiEykgtptDnUYlBuMBLjkMKZjKCzgiGMvowLnPijzBgDHVGxWNDSrbJoTJnDsgSEkDAteGmoWbtwQFphtuqptOPzfjDFajuQxeQJucPDksKCSJsThXQZcgUrblhvzUzggHDUFODnksxZvTUytQccsXpMXqrgZHlCRsFRGAhrfWKHfojYdNNBuEwqqfNOYsgWQKQJmBoiyJaDbDCBicFtzCbGpUUbEvlIEIKuqgOVZKfPOOBpGsJyeKEiVyuSmvTqNTdkBpBLEWWPxCKslZgLkJayoUzOqrTvNWnSLJUyGNLQiFpJGstNMXTUJPfNfGhxvtnBrgZhYkUtaVhIGtAGUrlUGefdvvWuoBGzcNoARUYXNfYDarTTfjXTyLNspUxDHMOKvmvmgnmOtEHBTmnGIEuEuDEMTmLwxgOPAITSPNbmmoVsYCippdehtsjPjgvKuKbfPTwkNvhlJVEzGdhhEisQLDhaJQXrshOGrXEjEtbsERyBaSvGKfhLrseWnJMbESKIrKZpIhvTAGVTkNBHDjXYjPjtCjPildTuLvSQsXsOAYnMDcVCEYjovcHxkduGydPNefxzntBQAQXvrqeRzAZpAKptWDEqRxpnDfpXdKETQxpiXqFRaKrUHVKMdrhZdyaEYlnkGyBlZKYGfpEsyWLkgrZZFgivJgbPdsArmzkPjOyEHNLULtEBDyqJaWUBDWGHnMAJvjnzPOJMouOjVJQXBdVDFxjSVwGyKhPRaRHqXDDGNyVYjCmoctwUZQltgXBmxhfbJuIpqRaTCgXGxSEgAYsBlguSmtdPMMqrslyXwuVTmxdbhpNMQRjveJQQKhnGRfifpDsTTAruNDYfhKoDFFQKMefkmzVTHSZjIHXQOrlfViiWSzchsLSzQkHaUWbyzgBiUJCsjsiYsLaPrOAmeQabwAIIEXULCGTvbdeMvAAkuJkpstLgHgIGwCKfdVPrBnkmeYEWxWzGseLrlESgZwXweyEMKNbRpvDFkcWgiGhGlTSPKjUKaaVmEDBVtgcluxeiiaWBAqEMaoRpAlSyISJScjuIbGZYBwuAhKqZslSHCZswIIvFLRoqxhiJzshtvZMKFEmkqffdOkHFydnURattSdPFIFrgNHkqqjEVJrqmnPHBDXMtvUWxYLSRQmmpDTMsUGLbSyaGesXgxGctArQPiUjBFHXMbxGTLqzuWTCOMcJyvYngddxQhrArpHkYgWvsJXfdvDbxqjvJoUOmjopZNJVjamNhgwdbuwAjQYdbeTlulnheYoJpKZMRaSDpBGjVIGfzzRGKlwYSePFgykzLbYgKNLyeAYDzHRDmkvhuRkArfQxIPXqtekDxPFdNPXrQedwTPkaPzaZrEQRVxqaqbTNZXFEnpDYgUDKXhCVOJyecvCdmNyaoSxSqsVlUtDLIpJcTJpJyxJdhbnKtvgatVHiPzkRikseBmjNwESRlHFkgVsAbYreSBTeJexRgoHSRxqjAHdlqSIeHHDgZevjLHVnKWtpFBkUkVGJpJSTHEDPPIcySvOMMBnpstiapoGXWlMtmedUeUeigNMtbheToMNGMVMVkomhdXuPSnlYtxJFttRAdyFnxyuraOnCZgbOUwVVDFEguLRugaTgiHvATuKyHzGRbNTVXHgFnFpjutxmnTSgjPfIqlngYujlsNwnVtRQoZuOYAjKlGzLSkcXpwwelbPbKDtnQtVMsUYvIekEYjSgPboopFkzvoGQUkieiLVeBuuPgBcZTfCIbcdBdAjYIObMjqkqwGSyonFQQWeUbnnDyJOFhkwFRHagrfSrcLhzGRQxmPxSCCqTYutVzXSKNdofudhGGZuZVHLBRuGCzqxHtSjsckSKdpCUjqEXqUJAfdJFZpoTPQUTHPfqWTBwOMgETadKesGSdNjtOjBRsdnwXgvhdGbZJIpNlWOVmgIGZckJzkmKJlbmUbLyuNdTPTGKYeISWeSevUtIKjdxAvxNKnqXnRgwECFqNCuwuVtjYfKGnstMZgWNbEAJSNlxUAeDnlzBHRzPXWljKuxwXIMVEhZhjRMhaSccxYDNSuJaJJBsHwnhxbFvNXzIlMjIWbhAquTyDvyUUrILdTLTWJftRlAxpvLcayLszBGIIcDYOjHoNEbshpmWjgeYOhrvPeNjahIeMizSIJFuySXhuTRKhkyiJtRUNrYrgyegvyjruBAPjfONZiXAdWamkazlGobcqahNYYDQiBasIMXTwnQjbMkbCAfISfANjiGNWGhjgOvUrrKQjVjniLWEaPxOOzhUScLIzGRUNYvICDvrXloYXhSFHDrzGSZsORpSYQYYoEkybZeVgsXYodtHvnOMPmhZSujdwDOCCCNLBpBWTkTPreJKfcMadItpjfrJgoSbmZigqOrnuhMtpbDFiLRQUqTnGcDZNUsXzUKqzlUzyGIGYcMRehnSdauPjoAJkPgtRtPKrPUQAUViiQCvYDatvXyxcyXnWYrLoGDkuPUkPNArFQDGmCvwTWuoKUiQUIZwDQDYModOcQKDrYTpOpivhVBDSEowsxFkCioVttCmGXURSMQvhBxTSeHsuslVXHKwMgukcvaVFPrYjilvDXICenlYOpRwwEnPYAAWppyxhNTXfAbXAQgimoFQwYNzAyCjYPCZyHysYirPMCroIhqdXvUgZpixaMMdWKVRgMievZFTdXwmBBKxaszbKciAomohyxaiVAumABUWHzeDoiZiPxBIETMemJhOAmBFZrDeQXwBJOOSCYowKgRkPXbYJXtIVHGAsmgMBqJVAikcqWQTOBInqhQDtsponRGasEnTIePICUWWxWTkQcMEfvcHFlZyaxttbGoUhBUfMnJJAmsuIXFLDDHoyrHgicwlTCNwzzlIKenHPZAMEgdLpcUjDWsgWxtiWQlqgibgKwokJzLeaWEUIVgzLZwcIFFHmvLqghGakFjhLGHJNgbqSrTDclyXGZqeHDfYvDicQVinFSqwAtQXFHtyDmbqMgRABizHfPukDGUZVwVMNzJQoizujWGZgDOeWKrqkpGLqlgCLSDWYvIoRdWCkeQaNZGRbndelCPFFoWSiBrJfiLPhGRVMXeyoZbVuCbuOnwZWcGwsFrZTTJnfkXjVRyoccfZGpkpzBNcIvnEwEjkbMxUIpjTGmurJwVDEnQlZSHZhxCopvPYwvtpyNUPvOuzFQBxpEqlKWWFbcxQpnrfSHlpwLPLYmyEqYroVembsdzcLGSwlrDEswPiFIZYoePVWcgSOhUlSrHFtRxpIpJYvxssUVjYXOpLsHbJGaTvtsKDuLKVdCsgfCLhvQTIWfQwIVFwNjjxTcwsLKysNJBwimtJVQmTBOakfcHUMKGKSppMEuFijFydZLRnfTofYSuNxRoXWfDSgrCUXtnsmUlsHGRwAfylzbVMtwipywXHYaVpnTYNChKUwnHYXUGWQlHYvZuvqKomJHLqRUiazbSiAZMxtvzPUVJnaEkjCZcRLjCpXjLXtHtFwJXakoomXSFBOZpipZuibAiCBuRlnLPusxCpcZsEmGBfKudfgamFutepGkzwOAsalXjjskgAeqOVFYhhskbKyrvwXDldJTSGsEYsbLpnPdIbMrTvvteGTKVTulHHdTDFjRAZXpaaldiBNGNSyehpwlQiqBMeYzqrqPsHZgBeQXrlQXgXaNPSEYfINjpRTfHKQlFxUMlDOLmEAFXUvsAVWRjVidvNFQLNQxOhdQyoUeUeIRUYUsvHRFoLhuFpSlBzRMBlAiZspmdGEVNxcXWDeRXwuAwqzQOEoYwrLhXqxPkfCKFqrjlDUQYLAABAbEhuRvbfwchVfUBCetaMZfQARlpjtAXKVVWTQLEuQDyskTnKxjvHjgvDRtRwzPSOOEaCwtmXaZkAYqeOJURHAmUbWMajawFkBUSxTLhvGXRUQiLGqZefJsmQeSBgDmaYVGlwuMeHvQuhdbZIIDqoWdndTPTFrqimZPvgvSGxwEmRGikOBfueMRXmxLfNPxehOFHerBacUqXJEYPPHQRQXkMBsbZsBQsYgFlQxuRGSarQyHMyANFWgapnxetarUMlynVfenZouyMynAAVgerjiqerkvNEVBFsBmofuxWNEsZDnYPAOlPTQCZWVeWqeOQMWRTdwUjCssPUVLFzzqObESYWmTnyCPWzLejCrVoUHfpJOpbtyWgyWxWtsAbTrKcIAiZIdkXDpMhQZgVGVgnAzgJbvxsGdFtBTohbMytqGadiyMdTyyPtapYjKgbQiRLWBavjmqtwFkTHqKWHFysnAHlKyLiCFmfjbLaPUsdyhxSADTypmXyPHcOkOroUDgkvHdUCoQFAkLYGuwHXqOwzdZqNkmfApzHLKgsYKrFxyGUtYkEKHCvQSRSoGlopFBDjWRmvWVGDElfdKUShCvsQNJYAmConvmtVmYShbjGDnFUyOChOPneaPynRhPbPSIeztsadkloyyIBxLFdxYbQEPMzrUeAMuXQWZTpaeLAoUnFWgKtovFxHaQKVSYDknPKAshbdXKolbbsMlZrudEmxSlIeygtHgjMSYHjMUZpWLyTdSGPbNTYRFkEfRQIMTQIzpaMamUvseMwobcbYoTVWHOZGnROVBmmVqpNCSHGvkSMauLjIcDIXIYWddKwXiFaheJrNUvSbbwUcYDCkBsqFxmJuBAzCqcRXUoAEhInWbTeHnTEoxKnwmJtHzjTWcqLQHgAghJLAJQZvXVWBsjuwMarOCRMWCLbGkYaewoAlobCoLkRMCpRzmTXQsFWvYNPvPUysJOAgKahZBOfTJlHnbNaCufajvPBVdUlufzkPmbwBigxgbhxOArVxVVyJtSitdzMZoIczofRUhmpQsBqXldwgInvDUxaRnthelIpnPXCQwTpsknvsrCQMZJQdkFScgJiKYaTyQvIgkAvSNbRtHmsuJVIMJnKBjSLUAxbjInaDcstrrjvzBPVhjyxQCXOYaiEGPYhaZQUmXYGqsQPHCqrPTsXUarfKNXScJvwblCJEHlOZEcmzdwKGemGVVYwmEGLsOzsZAMCekAvGPazDZuroQkgacNVDiolBXHuCnwfKpvUDNuFCKFxooSpGdKWhoJgMpOiryQaXfvcDpSpXrWKbzuqfxUMHIxTMRbuPVcNlAxheewVwUPkWYPXhilrzCpfVdNUXUcgbUDgUCIswlljHFNEEFPtsygPGVosgMAhjmEHdzCZberATrLMrGvtMijfMdXuebaMYmLQNLBsMErihoAIlZjxfnQlRBnGBGTCyywUyOlcHlzfIxZZCeluEckTbyuhYCAmqGFUcwlPTnCkVwGSfleXhRixRvSxbrZrMzGUEJfnbrUBcMxzNZvdeBehVJCTeGeVaSIScTTuEriyCwHdrSLYCLGldVbeFaJIshieNUyokQaQlusPzfKVVVRGXDsMWbOGrfazHoNLWOKYfpGkarKxRqoryZPKxprcMWaqUMMyZvpRngySIonmYHjzdqylRoYjYIwfhUasgmXlnUGPtoercjUmYQBIoRIYkxpeHaHSvPMhfMovjVOkysgQTyZcmRGXSGBOvvMDluiANXrjHHCEVrnhTAsQlCIOdGMlJlyabhctIjIbamdqBjyRlDZNSLQCylONQInFycZkOVkIoHvKKAlFsjdpkkqJmliyWrPHpCWnJkgauKzNCsdkSHZdoiWAzGQJDZqlqUtunACNDYkcEkuOvaYAqDrictWHGyaecvxnWHNygMkHqeIKfBKraZXXDYGNOpaqlwpHYXfUxelvSjqDJmIJyiwYnHQNysMRQjwvyFZPFjNuweqaWnOewVNqOHQRzMWQcdKnbVJldUELRqeqLtXIWIlvwmsfzwBXoyncNciJSKYeMnmbVFGjeSLLIKbktZTXSVMBFMlFIfoxL'
      end
    end
  end

  describe '#length_counter' do
    before { subject.react_polymer }

    context 'given ""' do
      let(:polymer) { file_polymer }

      it 'returns the string length' do
        expect(subject.length_counter).to eq 9808
      end
    end

    context "when polymer is 'dabAcCaCBAcCcaDA'" do
      let(:polymer) { 'dabAcCaCBAcCcaDA' }

      it 'returns 10' do
        expect(subject.length_counter).to eq 10
      end
    end
  end
end
