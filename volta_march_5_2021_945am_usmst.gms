$EOLCOM //
$TITLE VOLTA BASIN HYDROECONOMIC PROTOTYPE
$OFFSYMXREF OFFSYMLIST ONLISTING OFFUPPER

OPTION LIMROW=100000, LIMCOL = 0;
*OPTION iterlim = 10000000;
*OPTION Solprint=on;
*OPTION resLim= 1500;// the seconds model takes to run
                    // The model takes about 35 minutes to run
$Ontext
*----------------------------------------------------------------------------------------
Volta Basin Model: Expandable Prototype
* ---------------------------------------------------------------------------------------
Model has these FLOW nodes:
20 river gauge nodes
22 headdwater/tributary inflow nodes
62 diversion nodes - 45 ag and 17 ur
62 consumptive use nodes
62 water return flow nodes
6 unmeasured losses
13 reservoir release nodes and stock nodes
* ---------------------------------------------------------------------------------------
FLOWS:  Spatial unit for FLOWS is set (index) i.  It lists all flows by node and function.
Each element in the set i is also assigned to one water use function subset (category)
Subset categories include:
   1. Inflow nodes to the system,                                inflow(i);
   2. Nodes on a river or tributary                              river(i);
   3  Diversion nodes                                            divert(i);
   4. Consumptive uses                                           use(i);
   5. Return flow nodes directly to the river,                   return(i);
   6. unmeasured losses through evaporation or percolation       umlosses(i);
   7. NET reservoir releases from storage, outflow - inflow      rel(i);
STOCKS: Spatial unit for STOCKS is the set (index) u.
Each element of the set u is assigned to one water use subset (category).
Subset categories are:
   1. Reservoir nodes,                                           res(u).
* -----------------------------------------------------------------------------------------------
TABLE OF CONTENTS
   Section 1. Sets
   Section 2. Data
   Section 3. Variables
   Section 4. Equations
   Section 5. Models
   Section 6. Solves
   Section 7. Displays

* -----------------------------------------------------------------------------------------------

Contributors to the model

    Frank A. Ward :    (PhD Advisor)
    Dept of Agr Economics/Agr Business
    New Mexico State University, Las Cruces, NM USA
    e-mail: fward@nmsu.edu

    Bernard Baah-Kumi (PhD, Water Science and Management Program)
    New Mexico State University, Las Cruces, NM USA

    updated March 5, 2021

Volta Basin Treaty-Power Development Optimzation Model


Policy scenario 1: labelled 1_sto_dev_wo_treaty.  This label reflects water use patterns that
would occur under additional storage development and associated power production without a
multilateral water-power trade agreement.

It is implemented with a system optimization that permits additional storage capacity expansion and power production.
No trading of the added power production is permitted and no treaty constrains water sharing among the six countries.

Policy scenario 2: labelled 2_sto_dev_wi_treaty.  This label reflects water use patterns that would occur under
additional storage development that is forecast to occur with the multilateral water sharing and power trading arrangement.
It reflects a system optimization considering the additional storage capacity expansion with the agreement in place.
With the water sharing treaty implemented, the upstream countries are required to deliver historical average flows
to the only downstream riparian in exchange for hydropower if the added benefits economically justify the added costs.
Under the treaty, new power production and power trading (imports and exports) occurs, but historical water delivery
requirements must occur at the relevant international border stream gauges.

The classical gains from trade are reaped [Arkolakis et al., 2012; Bernard et al., 2007; Besley, 1995; Krugman, 1981],
in which the exporting country earns higher incomes than the income produced by using all the produced power for
domestic production. The importing country secures power at a cheaper cost (displaced income) than they
can supply it domestically.

This water sharing arrangement has some historical precedent.
These principles are used to implement the celebrated Rio Grande Compact
[Flanigan and Haas, 2008; Hill, 1974; Mix et al., 2012; F. A. Ward et al., 2007].

Under that agreement signed in 1938, three US states, Colorado, New Mexico, and Texas,
agreed at the Bishop's Lodge in Santa Fe New Mexico to divide the waters.

Under it, the states agreed to divide then future flows based on historical delivery patterns adjusted by natural
runoff at selected locations in the basin that had occurred prior to that time.  That compact added certainty to future
economic development in the region by allowing and encouraging future infrastructure developments in the basin like
additional storage. In fact, additional storage has been built encouraged by the economic development occurring
because of the greater predictability of flow rights and responsibilities for each of the three states [F.A.  Ward, 2013].
The text of the compact is currently (2021) posted [US Bureau of Reclamation, 2021].

A similarly-principled agreement has the potential to promote organized future developments in the Volta Basin.
Among other things it would require a six-country commission of some kind to enforce such a water sharing agreement,
in much the same way as the Rio Grande Compact Commission has operated in the US since the signing of the Compac
This would assure all states are meeting their agreed treaty water delivery requirements.

The equations equil_wi_trade_e and equil_wi_trade1_e
describe power trading possibilities with and without a water/power sharing treaty among the 6 Volta Basin countries

The variable Ave_flow_v with lower bounds defines average flows at various gauges that must be respected with the treaty


**************** Section 1 ***********************************************************************
*  The following sets are specified as indices                                                   *
*  for parameters (data), variables, and equations                                               *
**************************************************************************************************
$Offtext
*Section 1. Sets
Sets
**********************************************************************************************************
i     Flows -- location of important nodes in Volta Basin - Mali-Burkina-Benin-Togo-Côte d'Ivoire to Ghana
**********************************************************************************************************
/   BVSame_h_f           Headwater and tributary flow nodes            inflow(i)
    Sorou_h_f
    Nwok_h_f
    Dapola_h_f
    Bouga_h_f
    WhiteV_h_f
    White2_h_f
    DMon_h_f
    Arli_h_f
    Komp_h_f
    Oti_h_f
    Koum_h_f
    RedV_h_f
    Asibi_h_f
    Nasia_h_f
    Sisili_h_f
    Kulpn_h_f
    Tain_h_f
    Poni_h_f
    Bamba_h_f
    Kara_h_f
    Pru_h_f
    Daka_h_f
    Subin_h_f
    Mo_h_f
    Mole_h_f
    Afram_h_f
    Tod_h_f

    01_Samen_v_f        River flow gage measurement nodes              river (i)
    02_Nwokuy_v_f
    03_Dapola_v_f
    04_Noumb_v_f
    05_Wayen_v_f
    06_Bagre_v_f
    07_Arly_v_f
    08_Komp_v_f
    09_Mango_v_f
    10_Kouma_v_f
    11_Nangodi_v_f
    12_Pwalugu_v_f
    13_Nawuni_v_f
    14_Bamboi_v_f
    15_Sabari_v_f
    17_Prang_v_f
    16_Ekumdipe_v_f
    18_AkosomUp_v_f
    19_Senchi_v_f
    20_Kpong_v_f

    SamenAg_f            All agriculture nodes                             ag(i)
    NwokuyAg_f
    SourouAg_f
    SorouMAg_f
    LSeourAg_f
    DapolaAg_f
    BagriAg_f
    DuuliAg_f
    NoumbAg_f
    KanozoAg_f
    LoumbAg_f
    TensoAg_f
    PorgaAg_f
    DapaoAg_f
    SaviliAg_f
    NangoAg_f
    BagreAg_f
    GoogAg_f
    TYaruAg_f
    VeaAg_f
    TonoAg_f
    NZzanAg_f
    BuiAg_f
    PwaluAg_f
    SabariAg_f
    TanosoAg_f
    AkumaAg_f
    SubinjAg_f
    DipaliAg_f
    SogoAg_f
    LibgaAg_f
    GolgaAg_f
    BotangAg_f
    DaboAg_f
    YapeiAg_f
    NewLoAg_f
    AsanKAg_f
    BuipeAg_f
    AmateAg_f
    DedesoAg_f
    SataAg_f
    KpandoAg_f
    KpongAg_f
    AveyimAg_f
    AfifeAg_f


    BoboDUr_f               All urban water supply nodes                   ur(i)
    BanUr_f
    BoromoUr_f
    GaouaUr_f
    OugaUr_f
    KompeUr_f
    MeteUr_f
    DapoUr_f
    BagrUr_f
    BolgaUr_f
    WaUr_f
    BounaUr_f
    YendiUr_f
    SavelUr_f
    TamaleUr_f
    DambUr_f
    AccraUr_f

    BoboDUr_d_f                 Diversion nodes                        divert(i)
    SamenAg_d_f
    NwokuyAg_d_f
    SourouAg_d_f
    SorouMAg_d_f
    BanUr_d_f
    LSeourAg_d_f
    BoromoUr_d_f
    DapolaAg_d_f
    GaouaUr_d_f
    BagriAg_d_f
    DuuliAg_d_f
    NoumbAg_d_f
    KanozoAg_d_f
    LoumbAg_d_f
    OugaUr_d_f
    TensoAg_d_f
    KompeUr_d_f
    PorgaAg_d_f
    MeteUr_d_f
    DapoUr_d_f
    DapaoAg_d_f
    SaviliAg_d_f
    NangoAg_d_f
    BagrUr_d_f
    BagreAg_d_f
    GoogAg_d_f
    TYaruAg_d_f
    VeaAg_d_f
    BolgaUr_d_f
    TonoAg_d_f
    WaUr_d_f
    NZzanAg_d_f
    BounaUr_d_f
    BuiAg_d_f
    PwaluAg_d_f
    SabariAg_d_f
    TanosoAg_d_f
    AkumaAg_d_f
    YendiUr_d_f
    SubinjAg_d_f
    DipaliAg_d_f
    SogoAg_d_f
    LibgaAg_d_f
    SavelUr_d_f
    GolgaAg_d_f
    BotangAg_d_f
    DaboAg_d_f
    TamaleUr_d_f
    YapeiAg_d_f
    NewLoAg_d_f
    AsanKAg_d_f
    BuipeAg_d_f
    DambUr_d_f
    AmateAg_d_f
    DedesoAg_d_f
    SataAg_d_f
    KpandoAg_d_f
    KpongAg_d_f
    AveyimAg_d_f
    AfifeAg_d_f
    AccraUr_d_f

    BoboDUr_u_f               Consumptive use  flow nodes                 use(i)
    SamenAg_u_f
    NwokuyAg_u_f
    SourouAg_u_f
    SorouMAg_u_f
    BanUr_u_f
    LSeourAg_u_f
    BoromoUr_u_f
    DapolaAg_u_f
    GaouaUr_u_f
    BagriAg_u_f
    DuuliAg_u_f
    NoumbAg_u_f
    KanozoAg_u_f
    LoumbAg_u_f
    OugaUr_u_f
    TensoAg_u_f
    KompeUr_u_f
    PorgaAg_u_f
    MeteUr_u_f
    DapoUr_u_f
    DapaoAg_u_f
    SaviliAg_u_f
    NangoAg_u_f
    BagrUr_u_f
    BagreAg_u_f
    GoogAg_u_f
    TYaruAg_u_f
    VeaAg_u_f
    BolgaUr_u_f
    TonoAg_u_f
    WaUr_u_f
    NZzanAg_u_f
    BounaUr_u_f
    BuiAg_u_f
    PwaluAg_u_f
    SabariAg_u_f
    TanosoAg_u_f
    AkumaAg_u_f
    YendiUr_u_f
    SubinjAg_u_f
    DipaliAg_u_f
    SogoAg_u_f
    LibgaAg_u_f
    SavelUr_u_f
    GolgaAg_u_f
    BotangAg_u_f
    DaboAg_u_f
    TamaleUr_u_f
    YapeiAg_u_f
    NewLoAg_u_f
    AsanKAg_u_f
    BuipeAg_u_f
    DambUr_u_f
    AmateAg_u_f
    DedesoAg_u_f
    SataAg_u_f
    KpandoAg_u_f
    KpongAg_u_f
    AveyimAg_u_f
    AfifeAg_u_f
    AccraUr_u_f


    BoboDUr_r_f       Surface water return flow nodes                  return(i)
    SamenAg_r_f
    NwokuyAg_r_f
    SourouAg_r_f
    SorouMAg_r_f
    BanUr_r_f
    LSeourAg_r_f
    BoromoUr_r_f
    DapolaAg_r_f
    GaouaUr_r_f
    BagriAg_r_f
    DuuliAg_r_f
    NoumbAg_r_f
    KanozoAg_r_f
    LoumbAg_r_f
    OugaUr_r_f
    TensoAg_r_f
    KompeUr_r_f
    PorgaAg_r_f
    MeteUr_r_f
    DapoUr_r_f
    DapaoAg_r_f
    SaviliAg_r_f
    NangoAg_r_f
    BagrUr_r_f
    BagreAg_r_f
    GoogAg_r_f
    TYaruAg_r_f
    VeaAg_r_f
    BolgaUr_r_f
    TonoAg_r_f
    WaUr_r_f
    NZzanAg_r_f
    BounaUr_r_f
    BuiAg_r_f
    PwaluAg_r_f
    SabariAg_r_f
    TanosoAg_r_f
    AkumaAg_r_f
    YendiUr_r_f
    SubinjAg_r_f
    DipaliAg_r_f
    SogoAg_r_f
    LibgaAg_r_f
    SavelUr_r_f
    GolgaAg_r_f
    BotangAg_r_f
    DaboAg_r_f
    TamaleUr_r_f
    YapeiAg_r_f
    NewLoAg_r_f
    AsanKAg_r_f
    BuipeAg_r_f
    DambUr_r_f
    AmateAg_r_f
    DedesoAg_r_f
    SataAg_r_f
    KpandoAg_r_f
    KpongAg_r_f
    AveyimAg_r_f
    AfifeAg_r_f
    AccraUr_r_f


    Mali_uml_f             Unmeasured losses flow nodes                umloss(i)
    BFaso_uml_f
    Benin_uml_f
    Togo_uml_f
    CIvoire_uml_f
    Ghana_uml_f



    SAMEN_rel_f             Reservoir-to-river release flow nodes         rel(i)
    LERY_rel_f
    ZIGA_rel_f
    BAGRE_rel_f
    BATCH_rel_f
    KOMP_rel_f
    TONO_rel_f
    PWALU_rel_f
    BUI_rel_f
    TANOSO_rel_f
    AMATE_rel_f
    SUBIN_rel_f
    LVOLTA_rel_f
    KPONG_rel_f

    SAMEN_evap_f              Reservoir evaporation flow nodes           evap(i)
    LERY_evap_f
    ZIGA_evap_f
    BAGRE_evap_f
    KOMP_evap_f
    TONO_evap_f
    PWALU_evap_f
    BUI_evap_f
    TANOSO_evap_f
    AMATE_evap_f
    SUBIN_evap_f
    LVOLTA_evap_f
    KPONG_evap_f

    SAMEN_precip_f          Reservoir precipitation flow nodes         precip(i)
    LERY_precip_f
    ZIGA_precip_f
    BAGRE_precip_f
    KOMP_precip_f
    TONO_precip_f
    PWALU_precip_f
    BUI_precip_f
    TANOSO_precip_f
    AMATE_precip_f
    SUBIN_precip_f
    LVOLTA_precip_f
    KPONG_precip_f
/

*****************************************************************************************
*     Subsets of all Flow nodes above by class of node (function)
*****************************************************************************************

inflow(i)            Headwater and tributary flow nodes                inflow(i)
/     BVSame_h_f         Black Volta Headwaters from southwest Burkina Faso
      Sorou_h_f          Sourou river headwater tributary flow  from Mali
      Nwok_h_f           Nwokuy river headwater tributary flow in Burkina Faso
      Dapola_h_f         Dapola river headwater tributary flow in Burkina Faso
      Bouga_h_f          Bougariba tributary to Black Volta River
      WhiteV_h_f         White Volta  Headwaters up from northcentral Burkina Faso
      White2_h_f         Tributary flow to White Volta in Burkina Faso
      DMon_h_f           Dougoula Mondi tributary flow to White Volta in Burkina Faso
      Arli_h_f           Arli tributary flow in Burkina Faso
      Komp_h_f           Kompienga (Ouale) River Headwaters Tribuatary of Oti
      Oti_h_f            Oti or Panjari Headwater from northwest Benin
      Koum_h_f           Koumangou River Headwaters from Northwestern Benin Tributary of Oti
      RedV_h_f           Red Volta  Headwaters Tributary to White Volta from Burkina faso
      Asibi_h_f          Asibilika tributary of Sisili river
      Sisili_h_f         White Volta Tributary from Sissili Rivers in sourthern Burkina Faso
      Kulpn_h_f          Kulpawn River  Tributary flow to White Volta in sourthern Burkina Faso
      Nasia_h_f          Nasia headwater tributary flow in Ghana
      Tain_h_f           Tain tribtary flow in Ghana
      Poni_h_f           Poni river tributary of the Black volta in Ghana
      Bamba_h_f          Bambasou tributary to the Black Volta
      Kara_h_f           Kara tributary flow in Togo
      Pru_h_f            Pru River Headwaters Tributary of Lower Volta in Ghana
      Daka_h_f           Daka River Headwaters Tributary of Lower Volta in Ghana
      Subin_h_f          Subin River Headwater Tributary of Black Volta in Ghana
      Mo_h_f             Mo tributary flow in Togo
      Mole_h_f           Mole tributary flow to White Volta in Ghana
      Afram_h_f          Afram river tributary of main volta
      Tod_h_f            Todzie tributary to Lake Volta
/

river(i)             River gauge measurement nodes                      river(i)

/     01_Samen_v_f       guage at Samendeni on Black Volta in west Burkina Faso
      02_Nwokuy_v_f      guage at Nwokuy on Black Volta in west Burkina Faso
      03_Dapola_v_f      guage at Dapola on Black Volta in Burkina Faso
      04_Noumb_v_f       guage at Noumbiel on Burk Faso and Ghana border upstream Bui dam in Ghana
      05_Wayen_v_f       guage at Wayen on White Volta in northern Burkina Faso
      06_Bagre_v_f       guage at Bagre below Bagre Dam before river crosses from Burkina Faso to Ghana
      07_Arly_v_f        guage shows the flows on the Pendjari at the border between Burkina Faso and Benin
      08_Komp_v_f        guage at Kompienga river in B Faso downstream the Komp Dam before Oti
      09_Mango_v_f       guage at Mango in Togo-Ghana Border
      10_Kouma_v_f       guage at Koumangoui trbutary of Oti at Togo-Ghana Border
      11_Nangodi_v_f     guage at Nangodi on Red Volta in Ghana before the confluence of White Volta and Red Volta
      12_Pwalugu_v_f     guage at Pwalugu on White Volta in Ghana
      13_Nawuni_v_f      guage at Nawuni on White Volta in Ghana before the Akosombo Dam
      14_Bamboi_v_f      guage at Bamboi downstream of the Bui Dam in Ghana
      15_Sabari_v_f      guage at Sabari on Oti before Oti Lower Volta confluence upstream Lake
      17_Prang_v_f       guage at Prang on the Pru river in Ghana tributary of Lower Volta
      16_Ekumdipe_v_f    guage at Eumdipe on Daka river in Ghana tributary of Lower Volta
      18_AkosomUp_v_f    guage at upstream of Lake Volta
      19_Senchi_v_f      guage at Lower Volta downstream of Akosombo Dam and upsrteam Kpong dam
      20_Kpong_v_f       guage at downstream Kpong Reservoir and water enters Atantic Ocean
/

ag(i)                All major agriculture nodes                           ag(i)

/     SamenAg_f          Samendeni Irrigation in Burkina Faso
      NwokuyAg_f         Nwokuy Irrigation Scheme in Burkina Faso
      SourouAg_f         Sourou Irrigation Scheme in Burkina Faso
      SorouMAg_f         Sourou Irrigation in Mali
      LSeourAg_f         Lerinord Seourou Irrigation in Burkina Faso
      DapolaAg_f         Dapola Irrigation  Scheme in Burkina Faso
      BagriAg_f          Bagri Irrigation in Ghana
      DuuliAg_f          Duuli irrigation in Ghana
      NoumbAg_f          Noumbiel Irrigation Scheme in Burkina Faso
      KanozoAg_f         Yako Kanozoe Irrigation Scheme in Burkina Faso
      LoumbAg_f          Loumbila Irrigation Scheme in Burkina Faso
      TensoAg_f          Tensobenga Irrigation Scheme in Burkina Faso
      PorgaAg_f          Porga Irrigation Scheme in Benin
      DapaoAg_f          Dapaong Irrigation Sceme in Togo
      SaviliAg_f         Savili Irrigation Scheme in Burkina Faso
      NangoAg_f          Nangodi Irrigation Scheme in Burkina Faso
      BagreAg_f          Bagre Irrigation Scheme in Burkina Faso
      GoogAg_f           Goog irrigation in Ghana
      TYaruAg_f          Tiegu-Yarugu irrigation in Ghana
      VeaAg_f            Vea Irrigation Scheme in Ghana
      TonoAg_f           Tono Irrigation Scheme in Ghana
      NZzanAg_f          Nord-Zanzan Irrigation Scheme in Côte d'Ivoire
      BuiAg_f            Bui Irrigation Scheme in Ghana
      PwaluAg_f          Pwaulugu irrigation in Ghana
      SabariAg_f         Sabari Irrigation Scheme in Ghana
      TanosoAg_f         Tanoso Irrigation Scheme in Ghana
      AkumaAg_f          Akumadan Irrigation Scheme in Gahan
      SubinjAg_f         Subinja Irrigation Scheme in Ghana
      DipaliAg_f         Dipali irrigation in Ghana
      SogoAg_f           Sogo irrigation in Ghana
      LibgaAg_f          Libga Irrigation Scheme in Ghana
      GolgaAg_f          Golinga Irrigation Scheme in Ghana
      BotangAg_f         Botanga Irrigation Scheme in Ghana
      DaboAg_f           Daboya Irrigation in Ghana
      YapeiAg_f          Yapei Irrigation in Ghana
      NewLoAg_f          New Longoro Irrigation Scheme in Ghana
      AsanKAg_f          Asanatekwaa irrigation in Ghana
      BuipeAg_f          Buipe irrgation in Ghana
      AmateAg_f          Amate Irrigation Scheme in Ghana
      DedesoAg_f         Dedeso Irrigation Scheme in Ghana
      SataAg_f           Sata Irrgation Scheme in Ghana
      KpandoAg_f         Kpando-Torkor Irrigation Scheme in Ghana
      KpongAg_f          Kpong Irrigation Scheme in Ghana
      AveyimAg_f         Aveyimeh Irrigation Scheme in Ghana
      AfifeAg_f          Afife Irrigation Scheme in Ghana
/

ur(i)                All major urban water supply nodes                    ur(i)
/
     BoboDUr_f           Bobo-Dioulaso Urban water supply in Burkina Faso
     BanUr_f             Bankass Cercle urban water supply in Mali
     BoromoUr_f          Boromo Urban water supply in Burkina Faso
     GaouaUr_f           Gaoua domestic water withdrwal in B Faso
     OugaUr_f            Ouagadougou Urban water supply in Burkina Faso
     KompeUr_f           Kompienga Township water withdrawal in B Faso
     MeteUr_f            Meteri domestic water supply in Benin
     DapoUr_f            Dapaong water supply in Togo
     BagrUr_f            Bagre Urban water use in Burkina Faso
     BolgaUr_f           Bolgatanga Urban water supply in Ghana
     WaUr_f              Wa Urban water supply  in Ghana
     BounaUr_f           Bouna urban water supply in Côte d'Ivoire
     YendiUr_f           Yendi water withdrawal form daka river in Ghana
     SavelUr_f           Savelugu doemstic water supply in Ghana
     TamaleUr_f          Tamale Urban water supply in Ghana
     DambUr_f            Dambai doemstic water withdrawal in Ghana
     AccraUr_f           Accra Urban Water Supply in Ghana
/

divert(i)            Diversion nodes                                   divert(i)
/    BoboDUr_d_f           ag(i) + ur(i) nodes
     SamenAg_d_f
     NwokuyAg_d_f
     SourouAg_d_f
     SorouMAg_d_f
     BanUr_d_f
     LSeourAg_d_f
     BoromoUr_d_f
     DapolaAg_d_f
     GaouaUr_d_f
     BagriAg_d_f
     DuuliAg_d_f
     NoumbAg_d_f
     KanozoAg_d_f
     LoumbAg_d_f
     OugaUr_d_f
     TensoAg_d_f
     KompeUr_d_f
     PorgaAg_d_f
     MeteUr_d_f
     DapoUr_d_f
     DapaoAg_d_f
     SaviliAg_d_f
     NangoAg_d_f
     BagrUr_d_f
     BagreAg_d_f
     GoogAg_d_f
     TYaruAg_d_f
     VeaAg_d_f
     BolgaUr_d_f
     TonoAg_d_f
     WaUr_d_f
     NZzanAg_d_f
     BounaUr_d_f
     BuiAg_d_f
     PwaluAg_d_f
     SabariAg_d_f
     TanosoAg_d_f
     AkumaAg_d_f
     YendiUr_d_f
     SubinjAg_d_f
     DipaliAg_d_f
     SogoAg_d_f
     LibgaAg_d_f
     SavelUr_d_f
     GolgaAg_d_f
     BotangAg_d_f
     DaboAg_d_f
     TamaleUr_d_f
     YapeiAg_d_f
     NewLoAg_d_f
     AsanKAg_d_f
     BuipeAg_d_f
     DambUr_d_f
     AmateAg_d_f
     DedesoAg_d_f
     SataAg_d_f
     KpandoAg_d_f
     KpongAg_d_f
     AveyimAg_d_f
     AfifeAg_d_f
     AccraUr_d_f
/

agdivert(divert)      Diversion nodes per agricultural use           agdivert(i)

/   SamenAg_d_f         Samendeni Irrigation in Burkina Faso
    NwokuyAg_d_f        Nwokuy Irrigation in Burkina Faso
    SourouAg_d_f        Sourou Irrigation in Burkina Faso
    SorouMAg_d_f        Sourou Irrigation in Mali
    LSeourAg_d_f        Lerinord Sourou Irrigation in Burkina Faso
    DapolaAg_d_f        Dapola Irrigation  in Burkina Faso
    BagriAg_d_f         Bagri irrigation in Ghana
    DuuliAg_d_f         Duuli-Bagri Irrigation in Ghana
    NoumbAg_d_f         Noumbiel Irrigation in Burkina Faso
    KanozoAg_d_f        Yako Kanozoe Irrigation Scheme in Burkina Faso
    LoumbAg_d_f         Loumbila Irrigation Scheme in Burkina Faso
    TensoAg_d_f         Tensobenga Irrigation Scheme in Burkina Faso
    PorgaAg_d_f         Porga Irrigation in Benin
    DapaoAg_d_f         Dapaong Irrigation Sceme in Togo
    SaviliAg_d_f        Savili Irrigation Scheme in Burkina Faso
    NangoAg_d_f         Nangodi Irrigation in Burkina Faso
    BagreAg_d_f         Bagre Irrigation Scheme in Burkina Faso
    GoogAg_d_f          Goog Irrigation inn Ghana
    TYaruAg_d_f         Tiegu-Yarugu irrigation in Ghana
    VeaAg_d_f           Vea Irrigation in Ghana
    TonoAg_d_f          Tono Irrigation in Ghana
    NZzanAg_d_f         Nod-Zanzan Irrigation in Côte d'Ivoire
    BuiAg_d_f           Bui Irrigation Scheme in Ghana
    PwaluAg_d_f         Pwalugu irrigation in Ghana
    SabariAg_d_f        Sabari Irrigation in Ghana
    TanosoAg_d_f        Tanoso Irrigation in Ghana
    AkumaAg_d_f         Akumadan Irrigation Scheme in Gahan
    SubinjAg_d_f        Subinja Irrigation in Ghana
    DipaliAg_d_f        Dipali Irrigation in Ghana
    SogoAg_d_f          Sogo irrigation in Ghana
    LibgaAg_d_f         Libga Irrigation Scheme in Ghana
    GolgaAg_d_f         Golinga Irrigation Scheme in Ghana
    BotangAg_d_f        Botanga Irrigation in Ghana
    DaboAg_d_f          Daboya Irrigation in Ghana
    YapeiAg_d_f         Yapei irrigation in Ghana
    NewLoAg_d_f         New Longoro Irrigation Scheme in Ghana
    AsanKAg_d_f         Asanatekwaa irrigation in Ghana
    BuipeAg_d_f         Buipe Irrigation in Ghana
    AmateAg_d_f         Amate Irrigation in Ghana
    DedesoAg_d_f        Dedeso Irrigation Scheme in Ghana
    SataAg_d_f          Sata Irrgation Scheme in Ghana
    KpandoAg_d_f        Kpando-Torkor Irrigation Scheme in Ghana
    KpongAg_d_f         Kpong Irrigation in Ghana
    AveyimAg_d_f        Aveyimeh Irrigation Scheme in Ghana
    AfifeAg_d_f         Afife Irrigation SCheme in Ghana
/


urdivert (divert)      Diversion nodes per urban use                 urdivert(i)

/   BoboDUr_d_f         Bobo-Dioulasso Urban water supply in Burkina Faso
    BanUr_d_f           Bankass Cercle urban water diversion in Mali
    BoromoUr_d_f        Boromo Urban water supply in Burkina Faso
    GaouaUr_d_f         Gaoua doemstic water use in Burkina Faso
    OugaUr_d_f          Ouagadougou Urban water supply in Burkina Faso
    KompeUr_d_f         Kompienga domestic water supply in Burkina Faso
    MeteUr_d_f          Meteri domestic water supply in Benin
    DapoUr_d_f          Dapaong water supply in Togo
    BagrUr_d_f          Bagre urban water use in Burkina Faso
    BolgaUr_d_f         Bolgatanga Urban water supply in Ghana
    WaUr_d_f            Wa Urban water supply in Ghana
    BounaUr_d_f         Bouna urban water diversion in Côte d'Ivoire
    SavelUr_d_f         Savelugu domestic water supply in Ghana
    TamaleUr_d_f        Tamale Urban water supply in Ghana
    YendiUr_d_f         Yendi domestic water withdrawal in Ghana
    DambUr_d_f          Dambai doemstic water withdrawal in Ghana
    AccraUr_d_f         Accra Urban Water Supply in Ghana
/

use(i)               Consumptive use  nodes = div nodes                   use(i)
/   BoboDUr_u_f            Ag(i) + Ur(i) nodes
    SamenAg_u_f
    NwokuyAg_u_f
    SourouAg_u_f
    SorouMAg_u_f
    BanUr_u_f
    LSeourAg_u_f
    BoromoUr_u_f
    DapolaAg_u_f
    GaouaUr_u_f
    BagriAg_u_f
    DuuliAg_u_f
    NoumbAg_u_f
    KanozoAg_u_f
    LoumbAg_u_f
    OugaUr_u_f
    TensoAg_u_f
    KompeUr_u_f
    PorgaAg_u_f
    MeteUr_u_f
    DapoUr_u_f
    DapaoAg_u_f
    SaviliAg_u_f
    NangoAg_u_f
    BagrUr_u_f
    BagreAg_u_f
    GoogAg_u_f
    TYaruAg_u_f
    VeaAg_u_f
    BolgaUr_u_f
    TonoAg_u_f
    WaUr_u_f
    NZzanAg_u_f
    BounaUr_u_f
    BuiAg_u_f
    PwaluAg_u_f
    SabariAg_u_f
    TanosoAg_u_f
    AkumaAg_u_f
    YendiUr_u_f
    SubinjAg_u_f
    DipaliAg_u_f
    SogoAg_u_f
    LibgaAg_u_f
    SavelUr_u_f
    GolgaAg_u_f
    BotangAg_u_f
    DaboAg_u_f
    TamaleUr_u_f
    YapeiAg_u_f
    NewLoAg_u_f
    AsanKAg_u_f
    BuipeAg_u_f
    DambUr_u_f
    AmateAg_u_f
    DedesoAg_u_f
    SataAg_u_f
    KpandoAg_u_f
    KpongAg_u_f
    AveyimAg_u_f
    AfifeAg_u_f
    AccraUr_u_f
/
aguse(use)             Agricultural use nodes                           aguse(i)

/    SamenAg_u_f       same nodes as divert(i)
     NwokuyAg_u_f
     SourouAg_u_f
     SorouMAg_u_f
     LSeourAg_u_f
     DapolaAg_u_f
     BagriAg_u_f
     DuuliAg_u_f
     NoumbAg_u_f
     KanozoAg_u_f
     LoumbAg_u_f
     TensoAg_u_f
     PorgaAg_u_f
     DapaoAg_u_f
     SaviliAg_u_f
     NangoAg_u_f
     BagreAg_u_f
     GoogAg_u_f
     TYaruAg_u_f
     VeaAg_u_f
     TonoAg_u_f
     NZzanAg_u_f
     BuiAg_u_f
     PwaluAg_u_f
     SabariAg_u_f
     TanosoAg_u_f
     AkumaAg_u_f
     SubinjAg_u_f
     DipaliAg_u_f
     SogoAg_u_f
     LibgaAg_u_f
     GolgaAg_u_f
     BotangAg_u_f
     DaboAg_u_f
     YapeiAg_u_f
     NewLoAg_u_f
     AsanKAg_u_f
     BuipeAg_u_f
     AmateAg_u_f
     DedesoAg_u_f
     SataAg_u_f
     KpandoAg_u_f
     KpongAg_u_f
     AveyimAg_u_f
     AfifeAg_u_f
/

uruse(use)              Urban use nodes                                 uruse(i)

/    BoboDUr_u_f        same nodes as divert(i)
     BanUr_u_f
     BoromoUr_u_f
     GaouaUr_u_f
     OugaUr_u_f
     KompeUr_u_f
     MeteUr_u_f
     DapoUr_u_f
     BagrUr_u_f
     BolgaUr_u_f
     WaUr_u_f
     BounaUr_u_f
     SavelUr_u_f
     TamaleUr_u_f
     YendiUr_u_f
     DambUr_u_f
     AccraUr_u_f
/

return(i)            Surface water return flow nodes = div nodes       return(i)

/   BoboDUr_r_f
    SamenAg_r_f
    NwokuyAg_r_f
    SourouAg_r_f
    SorouMAg_r_f
    BanUr_r_f
    LSeourAg_r_f
    BoromoUr_r_f
    DapolaAg_r_f
    GaouaUr_r_f
    BagriAg_r_f
    DuuliAg_r_f
    NoumbAg_r_f
    KanozoAg_r_f
    LoumbAg_r_f
    OugaUr_r_f
    TensoAg_r_f
    KompeUr_r_f
    PorgaAg_r_f
    MeteUr_r_f
    DapoUr_r_f
    DapaoAg_r_f
    SaviliAg_r_f
    NangoAg_r_f
    BagrUr_r_f
    BagreAg_r_f
    GoogAg_r_f
    TYaruAg_r_f
    VeaAg_r_f
    BolgaUr_r_f
    TonoAg_r_f
    WaUr_r_f
    NZzanAg_r_f
    BounaUr_r_f
    BuiAg_r_f
    PwaluAg_r_f
    SabariAg_r_f
    TanosoAg_r_f
    AkumaAg_r_f
    YendiUr_r_f
    SubinjAg_r_f
    DipaliAg_r_f
    SogoAg_r_f
    LibgaAg_r_f
    SavelUr_r_f
    GolgaAg_r_f
    BotangAg_r_f
    DaboAg_r_f
    TamaleUr_r_f
    YapeiAg_r_f
    NewLoAg_r_f
    AsanKAg_r_f
    BuipeAg_r_f
    DambUr_r_f
    AmateAg_r_f
    DedesoAg_r_f
    SataAg_r_f
    KpandoAg_r_f
    KpongAg_r_f
    AveyimAg_r_f
    AfifeAg_r_f
    AccraUr_r_f
/

agreturn(return)      Agricultural return (surface) flow nodes       agreturn(i)

/   SamenAg_r_f       same nodes as divert(i)
    NwokuyAg_r_f
    SourouAg_r_f
    SorouMAg_r_f
    LSeourAg_r_f
    DapolaAg_r_f
    BagriAg_r_f
    DuuliAg_r_f
    NoumbAg_r_f
    KanozoAg_r_f
    LoumbAg_r_f
    TensoAg_r_f
    PorgaAg_r_f
    DapaoAg_r_f
    SaviliAg_r_f
    NangoAg_r_f
    BagreAg_r_f
    GoogAg_r_f
    TYaruAg_r_f
    VeaAg_r_f
    TonoAg_r_f
    NZzanAg_r_f
    BuiAg_r_f
    PwaluAg_r_f
    SabariAg_r_f
    TanosoAg_r_f
    AkumaAg_r_f
    SubinjAg_r_f
    DipaliAg_r_f
    SogoAg_r_f
    LibgaAg_r_f
    GolgaAg_r_f
    BotangAg_r_f
    DaboAg_r_f
    YapeiAg_r_f
    NewLoAg_r_f
    AsanKAg_r_f
    BuipeAg_r_f
    AmateAg_r_f
    DedesoAg_r_f
    SataAg_r_f
    KpandoAg_r_f
    KpongAg_r_f
    AveyimAg_r_f
    AfifeAg_r_f
/

urreturn(return)      Urban return (surface) flow nodes              urreturn(i)

/   BoboDUr_r_f       same nodes as divert(i)
    BanUr_r_f
    BoromoUr_r_f
    GaouaUr_r_f
    OugaUr_r_f
    KompeUr_r_f
    MeteUr_r_f
    DapoUr_r_f
    BagrUr_r_f
    BolgaUr_r_f
    WaUr_r_f
    BounaUr_r_f
    SavelUr_r_f
    TamaleUr_r_f
    YendiUr_r_f
    DambUr_r_f
    AccraUr_r_f
/

umloss(i)             Unmeasured losses flow nodes                     umloss(i)
/
    Mali_uml_f            Unmeasured losses in Mali
    BFaso_uml_f           Unmeasured losses in Burkina Faso
    Benin_uml_f           Unmeasured losses in Benin
    Togo_uml_f            Unmeasured losses in Togo
    CIvoire_uml_f         Unmeasured losses in Côte d'Ivoire
    Ghana_uml_f           Unmeasured losses in Ghana
/

rel(i)      Reservoir to river net release flow nodes(outflow - Inflow)   rel(i)
/
    SAMEN_rel_f          Samendeni reservoir releases to Mouhoun (Black Volta)
    LERY_rel_f           Lery reservoir releases to Sourou River Tributary of Black Volta or Mouhoun
    ZIGA_rel_f           Ziga reservior releases to White Volta or Nakambe mainstem
    BAGRE_rel_f          Bagre reservoir releases to White Volta or Nakambe mainstem
    KOMP_rel_f           Kompienga reservior releases to Kompienga River tributary of Oti River
    TONO_rel_f           Tono reservoir releases to Tono River tributary of White Volta
    PWALU_rel_f          Pwalugu reservior releases to White Volta river
    BUI_rel_f            Bui reservoir releases to Black Volta mainstem
    TANOSO_rel_f         Tanoso reservior releases to Pru River tribuary of Lower Volta
    AMATE_rel_f          Amate reservior releases to Daka River tributary of Lower Volta
    SUBIN_rel_f          Subinja reservior releases to Black Volta
    LVOLTA_rel_f         Akosombo dam releases to Volta Mainstem ds to Kpong dam near the Estuary
    KPONG_rel_f          Kpong reservior releases to Mainstem Volta to the Estuary
/

evap(i)                  Reservoir evaporation flow nodes                evap(i)
/
    SAMEN_evap_f         Samendeni reservoir evaporation      //New
    LERY_evap_f          Lery reservior evaporation
    ZIGA_evap_f          Ziga reservior evaporation
    BAGRE_evap_f         Bagre reservoir evaporation
    KOMP_evap_f          Kompienga reservior evaporation
    TONO_evap_f          Tono reservoir evaporation
    PWALU_evap_f         Pwalugu reservior evaporation        //New
    BUI_evap_f           Bui reservoir evaporation
    TANOSO_evap_f        Tanoso reservior evaporation
    AMATE_evap_f         Amate reservoir evaporation
    SUBIN_evap_f         Subinja reservoir evaporation
    LVOLTA_evap_f        Akosombo or Volta reservior evaporation
    KPONG_evap_f         Kpong reservior evaporation
/

precip(i)               Reservoir precipitation flow nodes            precip(i)
/
    SAMEN_precip_f      Precipitation into Samendeni reservoir       //New
    LERY_precip_f       Precipitation into Samendeni reservior
    ZIGA_precip_f       Precipitation into Ziga reservior
    BAGRE_precip_f      Precipitation into Bagre reservior
    KOMP_precip_f       Precipitation into Kompienga reservior
    TONO_precip_f       Precipitation into Tono reservior
    PWALU_precip_f      Precipitation into Pwalugu reservior         //New
    BUI_precip_f        Precipitation into Bui reservior
    TANOSO_precip_f     Precipitation into Tanoso reservior
    AMATE_precip_f      Precipitation into Amate reservior
    SUBIN_precip_f      Precipitation into Subinja reservior
    LVOLTA_precip_f     Precipitation into main Volta reservior
    KPONG_precip_f      Precipitation into Kpong reservior
/

hydro(i)                 Hydro producing gauge
/
    01_Samen_v_f
    06_Bagre_v_f
    08_Komp_v_f
    12_Pwalugu_v_f
    14_Bamboi_v_f
    19_Senchi_v_f
    20_Kpong_v_f
/

*****************************************************************************************
u     Stocks -- location of important stock nodes -- reservoirs only for now
*****************************************************************************************
/   01_SAMEN_res_s       Reservoir stock nodes                            res(u)
    02_LERY_res_s
    03_ZIGA_res_s
    04_BAGRE_res_s
    05_KOMP_res_s
    06_TONO_res_s
    07_PWALU_res_s
    08_BUI_res_s
    09_TANOSO_res_s
    10_AMATE_res_s
    11_SUBIN_res_s
    12_LVOLTA_res_s
    13_KPONG_res_s
/
*****************************************************************************************
*    Stock subsets lets us classify stocks by function (e.g. reservoir for now)
*****************************************************************************************
res(u)               Reservoir stock nodes
/   01_SAMEN_res_s          Samendeni reservoir storage volume on Black Volta BF
    02_LERY_res_s           Lery reservoir stock storage volume on Black Volta BF
    03_ZIGA_res_s           Ziga reservoir stock storage volume on White Volta BF
    04_BAGRE_res_s          Bagre reservoir stock storage volume on White Volta BF
    05_KOMP_res_s           Kompienga reservior stock storage volume on Kompienga River BF
    06_TONO_res_s           Tono reservoir stock storage volume on Tono River GH
    07_PWALU_res_s          Pwalugu reservior stock volume on the White Volta river
    08_BUI_res_s            Bui reservoir stock storage volume on Black Volta GH
    09_TANOSO_res_s         Tanoso reservior stock storage volume on Pru River GH
    10_AMATE_res_s          Amate reservoir stock storage volume on Daka River GH
    11_SUBIN_res_s          Subinja reservoir stock storage volume on Black Volta GH
    12_LVOLTA_res_s         Lake Volta stock storage volume on Mainstem Volta GH
    13_KPONG_res_s          Kpong reservior storage volume on Mainstem Volta GH
/

bh(res, hydro)        Hydro reservoir downstream gauge combination
/
 01_SAMEN_res_s .01_Samen_v_f
 04_BAGRE_res_s .06_Bagre_v_f
 05_KOMP_res_s  .08_Komp_v_f
 07_PWALU_res_s .12_Pwalugu_v_f
 08_BUI_res_s   .14_Bamboi_v_f
 12_LVOLTA_res_s.19_Senchi_v_f
 13_KPONG_res_s .20_Kpong_v_f
/

*****************************************************************************************
j     crop            Major crops Irrigated in Volta Basin
*****************************************************************************************
/ Rice
  Vege
  Legu
/

jg(j)  grain crops
/ Rice
  Legu
/
jv(j)  vegetable crops
/Vege/

*************************************************************************************************
s  water supply or availability scenario allows testing impacts of drought& flood-climate change
*************************************************************************************************
/ Histor_flow
  CliStr_flow
/

*************************************************************************************************
m  storage development scenario
*************************************************************************************************
/
  Plus_PMD_SMD
/
* Plus_only_PMD Only_Exist_dams : Many different scenarios can be added

*************************************************************************************************
p  policy
*************************************************************************************************
/
1_sto_dev_wo_treaty
2_sto_dev_wi_treaty
/


*************************************************************************************************
r  riparian countries
*************************************************************************************************
/01_Mali,02_BFaso,03_Benin, 04_Togo,05_CIvoire, 06_Ghana/
*************************************************************************************************
*The heaviest rain in the south is from late April until June July and August,
*And a lighter rain possible during September and and early October.
*In the northern part of the basin, the rain season is continuous,from late April until early Oct.
*north is pretty dry and south is pretty wet
*************************************************************************************************
t  time
*************************************************************************************************
/01*20/    // 20 max

*Code for season by year
k  seasons per year
*************************************************************************************************
/Wet
 Dry/

ks irrigation is done only in the dry season (rainfed agriculture is done in the wet season)
/Dry/
*************************************************************************************************
*rainy season-June to October(cool rainy and wet)
*harmattan season-November to March (hot and dry)
*************************************************************************************************
tlast (t)      terminal period among all years above
tfirst(t)      first year

*tearly(t)      first half of years
*tlater(t)      last half of years

sfirst(k)      first season any year
slast (k)      terminal season any year

kn    (k)      off irrigation season - no irrigation in the wet season

timelast(t,k)  last year and last season
;

* define last year and last season
tfirst(t) = yes $ (ord(t) eq 1);      //  first year
tlast (t) = yes $ (ord(t) eq card(t));//  last year

*tearly(t) = yes $ (ord(t) lt 5);       // 1st half
*tlater(t) = yes $ (ord(t) ge 5);       // last half

sfirst(k) = yes $ (ord(k) eq 1);      //  first season
slast (k) = yes $ (ord(k) eq card(k));//  last season

timelast(t,k) = yes $ [(ord(t) eq card(t)) and (ord(k) eq card(k))];

kn(k)    = not ks(k);

display kn;


parameters
LINKTIME(t,k,t,k)         // parameter defined for linking adjacent time periods (trick)
;
alias (k,k2),(t,t2)
;

* defines sequencing of seasons and years
* it requires  harmattan year 2 to follow rainy season year 1 and so on.


loop(t,loop(k$(ord(k)+ord(t) gt 2),
       linktime(t,k,t,k-1) $(ord(k) gt 1)        = yes;
       linktime(t,k,t-1,k2  )$
          (ord(k) eq 1 and ord(k2) eq card(k2))  = yes;
      ));
;

option  linktime:4:0:1;
display linktime;


*************************************************************************************************
* Mathematical tricks streamline the model
*************************************************************************************************
* lets some tables' nodes be rows or columns
ALIAS (t,tp),   (s,sp);
ALIAS (i,ip);
ALIAS (river,  riverp);
ALIAS (divert,divertp);

Parameters
ID_du_p(divert,  use)  identify matrix connects divert nodes to use nodes
ID_uu_p(use  ,   use)  identity matrix connects use nodes to use nodes
ID_ru_p(return,  use)  identity matrix connects return nodes to use nodes
ID_lu_p(umloss,  use)  identity matrix connects unmeasured loss nodes to use nodes

ID_dr_p(divert,  return) identity matrix connects divert nodes to return nodes
ID_ur_p(use,     return) identity matrix connects use nodes to return nodes
;

ID_ru_p(return,  use) $ (ord(return) eq ord(use    )) = 1;
ID_uu_p(use   ,  use) $ (ord(use   ) eq ord(use    )) = 1;
ID_du_P(divert,  use) $ (ord(divert) eq ord(use    )) = 1;
ID_lu_p(umloss,  use) $ (ord(umloss) eq ord(use    )) = 1;

ID_dr_p(divert,return) $ (ord(divert) eq ord(return)) = 1;
ID_ur_P(use,   return) $ (ord(use   ) eq ord(return)) = 1;

Display ID_ru_p, ID_uu_p, ID_du_p, ID_lu_p, ID_dr_p, ID_ur_P;

****------------------------------------------------------------*************************
*Section 2. Data
**************** Section 2 **************************************************************
*  This section defines all data in 3 formats                                           *
*  1.  Scalars (single numbers),                                                        *
*  2.  Parameters (columns of numbers) or                                               *
*  3.  Tables (data in rows and columns)                                                *
*****************************************************************************************
scalar
epsilon           Small number to avoid dividing by zero
/ .0001/
*  Below are several maps summarizing a basin's geometry
*  By geometry we mean location of mainstems, tributaries, confluence,
*  source nodes, use nodes, return flow nodes, reservoir nodes, etc.
*  Basin geometry is summarized through judicious use of numbers 1, -1, and 0 (blank)
*****************************************************************************************
*  Map #1:
*  Each column below is a streamgage.  Each row is a source or use of water.
*  Flow at each gage (column) is directly influenced by at least 1 upstream row.
*  SOURCE adds to columns flow             (+1)
*  USE deplete from col flow               (-1)
*  BLANK has no effect on col flow         (  )
*  Geometry accounts for all sources (supplies) and uses (demands) in basin

*  Map is used to produce coefficients in equations below to define:
*  X(river) = Bhv * X(inflow) + Bvv * X(river)   + Bdv * X(divert)
*           + Brv * X(return) + Buv * X(unmeasuredflows) + BLv * X(rel)
*
*  These B coeff vectors are stacked below as a single matrix, Bv
*****************************************************************************************
Table Bv_p(i,river)    Hydrologic Balance Map
****************************   Column Heads are River Gauges    ********************************************************************************************************************
                 01_Samen_v_f   02_Nwokuy_v_f   03_Dapola_v_f   04_Noumb_v_f     05_Wayen_v_f    06_Bagre_v_f     07_Arly_v_f    08_Komp_v_f     09_Mango_v_f      10_Kouma_v_f
* ---------------- headwater inflow node rows (+) ----------------------------------------------------------------------------------------------------------------------------------
BVSame_h_f            1
Sorou_h_f                                            1
Nwok_h_f                             1
Dapola_h_f                                           1
Bouga_h_f                                                            1
WhiteV_h_f                                                                           1
White2_h_f                                                                                             1
DMon_h_f                                                                                               1
Arli_h_f                                                                                                               1
Komp_h_f                                                                                                                               1
Oti_h_f                                                                                                                                               1
Koum_h_f                                                                                                                                                                1
RedV_h_f
Asibi_h_f
Nasia_h_f
Sisili_h_f
Kulpn_h_f
Tain_h_f
Poni_h_f
Bamba_h_f
Kara_h_f
Pru_h_f
Daka_h_f
Subin_h_f
Mo_h_f
Mole_h_f
Afram_h_f
Tod_h_f
* ---------------- river gage node rows (+) ----------------------------------------------------------------------------------------------------------------------------------------
01_Samen_v_f                         1
02_Nwokuy_v_f                                        1
03_Dapola_v_f                                                       1
04_Noumb_v_f
05_Wayen_v_f                                                                                           1
06_Bagre_v_f
07_Arly_v_f                                                                                                                                           1
08_Komp_v_f                                                                                                                                           1
09_Mango_v_f
10_Kouma_v_f
11_Nangodi_v_f
12_Pwalugu_v_f
13_Nawuni_v_f
14_Bamboi_v_f
15_Sabari_v_f
17_Prang_v_f
16_Ekumdipe_v_f
18_AkosomUp_v_f
19_Senchi_v_f
20_Kpong_v_f
* --------------- diversion nodes  (-)  -----------------------------------------------------------------------------------------------------------------------------------------
BoboDUr_d_f          -1
SamenAg_d_f                         -1
NwokuyAg_d_f                                        -1
SourouAg_d_f                                        -1
SorouMAg_d_f                                        -1
BanUr_d_f                                           -1
LSeourAg_d_f                                        -1
BoromoUr_d_f                                        -1
DapolaAg_d_f                                                      -1
GaouaUr_d_f                                                       -1
BagriAg_d_f                                                       -1
DuuliAg_d_f                                                       -1
NoumbAg_d_f
KanozoAg_d_f                                                                        -1
LoumbAg_d_f                                                                         -1
OugaUr_d_f                                                                                            -1
TensoAg_d_f                                                                                           -1
KompeUr_d_f                                                                                                                                          -1
PorgaAg_d_f                                                                                                                                          -1
MeteUr_d_f                                                                                                                                           -1
DapoUr_d_f                                                                                                                                           -1
DapaoAg_d_f                                                                                                                                          -1
SaviliAg_d_f
NangoAg_d_f
BagrUr_d_f
BagreAg_d_f
GoogAg_d_f
TYaruAg_d_f
VeaAg_d_f
BolgaUr_d_f
TonoAg_d_f
WaUr_d_f                                                          -1
NZzanAg_d_f
BounaUr_d_f
BuiAg_d_f
PwaluAg_d_f
SabariAg_d_f
TanosoAg_d_f
AkumaAg_d_f
YendiUr_d_f
SubinjAg_d_f
DipaliAg_d_f
SogoAg_d_f
LibgaAg_d_f
SavelUr_d_f
GolgaAg_d_f
BotangAg_d_f
DaboAg_d_f
TamaleUr_d_f
YapeiAg_d_f
NewLoAg_d_f
AsanKAg_d_f
BuipeAg_d_f
DambUr_d_f
AmateAg_d_f
DedesoAg_d_f
SataAg_d_f
KpandoAg_d_f
KpongAg_d_f
AveyimAg_d_f
AfifeAg_d_f
AccraUr_d_f
* -------------- return flow node rows (+) ------------------------------------------------------------------------------------------------------------------------------------------
BoboDUr_r_f           1
SamenAg_r_f                          1
NwokuyAg_r_f                                         1
SourouAg_r_f                                         1
SorouMAg_r_f                                         1
BanUr_r_f                                            1
LSeourAg_r_f                                         1
BoromoUr_r_f                                         1
DapolaAg_r_f                                                      1
GaouaUr_r_f                                                       1
BagriAg_r_f                                                       1
DuuliAg_r_f                                                       1
NoumbAg_r_f
KanozoAg_r_f                                                                         1
LoumbAg_r_f                                                                          1
OugaUr_r_f                                                                                             1
TensoAg_r_f                                                                                            1
KompeUr_r_f                                                                                                                                           1
PorgaAg_r_f                                                                                                                                           1
MeteUr_r_f                                                                                                                                            1
DapoUr_r_f                                                                                                                                            1
DapaoAg_r_f                                                                                                                                           1
SaviliAg_r_f
NangoAg_r_f
BagrUr_r_f
BagreAg_r_f
GoogAg_r_f
TYaruAg_r_f
VeaAg_r_f
BolgaUr_r_f
TonoAg_r_f
WaUr_r_f                                                           1
NZzanAg_r_f
BounaUr_r_f
BuiAg_r_f
PwaluAg_r_f
SabariAg_r_f
TanosoAg_r_f
AkumaAg_r_f
YendiUr_r_f
SubinjAg_r_f
DipaliAg_r_f
SogoAg_r_f
LibgaAg_r_f
SavelUr_r_f
GolgaAg_r_f
BotangAg_r_f
DaboAg_r_f
TamaleUr_r_f
YapeiAg_r_f
NewLoAg_r_f
AsanKAg_r_f
BuipeAg_r_f
DambUr_r_f
AmateAg_r_f
DedesoAg_r_f
SataAg_r_f
KpandoAg_r_f
KpongAg_r_f
AveyimAg_r_f
AfifeAg_r_f
AccraUr_r_f
* -------------- unmeausred losses (-) -------------------------------------------------------------------------------------------------------------------------------------------
Mali_uml_f
BFaso_uml_f
Benin_uml_f
Togo_uml_f
CIvoire_uml_f
Ghana_uml_f
* ------------- reservoir release node rows (+) ----------------------------------------------------------------------------------------------------------------------------------
SAMEN_rel_f          1
LERY_rel_f                                           1
ZIGA_rel_f                                                                           1
BAGRE_rel_f                                                                                            1
KOMP_rel_f                                                                                                                             1
TONO_rel_f
PWALU_rel_f
BUI_rel_f
SUBIN_rel_f
TANOSO_rel_f
AMATE_rel_f
LVOLTA_rel_f
KPONG_rel_f
*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
+               11_Nangodi_v_f    12_Pwalugu_v_f    13_Nawuni_v_f    14_Bamboi_v_f    15_Sabari_v_f    17_Prang_v_f   16_Ekumdipe_v_f   18_AkosomUp_v_f    19_Senchi_v_f    20_Kpong_v_f
* ----------------headwater inflow node rows (+) ---------------------------------------------------------------------------------------------------------------------------------------
BVSame_h_f
Sorou_h_f
Nwok_h_f
Dapola_h_f
Bouga_h_f
WhiteV_h_f
White2_h_f
DMon_h_f
Arli_h_f
Komp_h_f
Oti_h_f
Koum_h_f
RedV_h_f               1
Asibi_h_f                              1
Nasia_h_f                                               1
Sisili_h_f                                              1
Kulpn_h_f                                               1
Tain_h_f                                                                 1
Poni_h_f                                                                 1
Bamba_h_f                                                                1
Kara_h_f                                                                                  1
Pru_h_f                                                                                                   1
Daka_h_f                                                                                                                   1
Subin_h_f                                                                                                                                   1
Mo_h_f                                                                                                                                      1
Mole_h_f                                                                                                                                    1
Afram_h_f                                                                                                                                                      1
Tod_h_f                                                                                                                                                        1
* ----------------gage node rows (+) -------------------------------------------------------------------------------------------------------------------------------------------------
01_Samen_v_f
02_Nwokuy_v_f
03_Dapola_v_f
04_Noumb_v_f                                                             1
05_Wayen_v_f
06_Bagre_v_f                           1
07_Arly_v_f
08_Komp_v_f
09_Mango_v_f                                                                            1
10_Kouma_v_f                                                                            1
11_Nangodi_v_f                         1
12_Pwalugu_v_f                                          1
13_Nawuni_v_f                                                                                                                               1
14_Bamboi_v_f                                                                                                                               1
15_Sabari_v_f                                                                                                                               1
17_Prang_v_f                                                                                                                                1
16_Ekumdipe_v_f                                                                                                                             1
18_AkosomUp_v_f                                                                                                                                                1
19_Senchi_v_f                                                                                                                                                                   1
20_Kpong_v_f
* ----------------diversion nodes  (-)  ------------------------------------------------------------------------------------------------------------------------------------------------
BoboDUr_d_f
SamenAg_d_f
NwokuyAg_d_f
SourouAg_d_f
SorouMAg_d_f
BanUr_d_f
LSeourAg_d_f
BoromoUr_d_f
DapolaAg_d_f
GaouaUr_d_f
BagriAg_d_f
DuuliAg_d_f
NoumbAg_d_f                                                             -1
KanozoAg_d_f
LoumbAg_d_f
OugaUr_d_f
TensoAg_d_f
KompeUr_d_f
PorgaAg_d_f
MeteUr_d_f
DapoUr_d_f
DapaoAg_d_f
SaviliAg_d_f          -1
NangoAg_d_f           -1
BagrUr_d_f                            -1
BagreAg_d_f                           -1
GoogAg_d_f                            -1
TYaruAg_d_f                           -1
VeaAg_d_f                             -1
BolgaUr_d_f                           -1
TonoAg_d_f                            -1
WaUr_d_f
NZzanAg_d_f                                                              -1
BounaUr_d_f                                                              -1
BuiAg_d_f                                                                -1
PwaluAg_d_f                                            -1
SabariAg_d_f                                                                             -1
TanosoAg_d_f                                                                                              -1
AkumaAg_d_f                                                                                               -1
YendiUr_d_f                                                                                                               -1
SubinjAg_d_f                                                                                                                               -1
DipaliAg_d_f                                                                                                                               -1
SogoAg_d_f                                                                                                                                 -1
LibgaAg_d_f                                                                                                                                -1
SavelUr_d_f                                                                                                                                -1
GolgaAg_d_f                                                                                                                                -1
BotangAg_d_f                                                                                                                               -1
DaboAg_d_f                                                                                                                                 -1
TamaleUr_d_f                                                                                                                               -1
YapeiAg_d_f                                                                                                                                -1
NewLoAg_d_f                                                                                                                                -1
AsanKAg_d_f                                                                                                                                -1
BuipeAg_d_f                                                                                                                                -1
DambUr_d_f                                                                                                                                 -1
AmateAg_d_f                                                                                                                                                -1
DedesoAg_d_f                                                                                                                                               -1
SataAg_d_f                                                                                                                                                 -1
KpandoAg_d_f                                                                                                                                               -1
KpongAg_d_f                                                                                                                                                                     -1
AveyimAg_d_f                                                                                                                                                                    -1
AfifeAg_d_f                                                                                                                                                                     -1
AccraUr_d_f                                                                                                                                                                     -1
* ----------------flow node rows (+) --------------------------------------------------------------------------------------------------------------------------------------------------
BoboDUr_r_f
SamenAg_r_f
NwokuyAg_r_f
SourouAg_r_f
SorouMAg_r_f
BanUr_r_f
BoromoUr_r_f
LSeourAg_r_f
DapolaAg_r_f
GaouaUr_r_f
BagriAg_r_f
DuuliAG_r_f
NoumbAg_r_f                                                              1
KanozoAg_r_f
LoumbAg_r_f
OugaUr_r_f
TensoAg_r_f
KompeUr_r_f
PorgaAg_r_f
MeteUr_r_f
DapoUr_r_f
DapaoAg_r_f
SaviliAg_r_f          1
NangoAg_r_f           1
BagrUr_r_f                             1
BagreAg_r_f                            1
GoogAg_r_f                             1
TYaruAg_r_f                            1
VeaAg_r_f                              1
BolgaUr_r_f                            1
TonoAg_r_f                             1
WaUr_r_f
NZzanAg_r_f                                                               1
BounaUr_r_f                                                               1
BuiAg_r_f                                                                 1
PwaluAg_r_f                                             1
SabariAg_r_f                                                                              1
TanosoAg_r_f                                                                                              1
AkumaAg_r_f                                                                                               1
YendiUr_r_f                                                                                                              1
SubinjAg_r_f                                                                                                                               1
DipaliAg_r_f                                                                                                                               1
SogoAg_r_f                                                                                                                                 1
LibgaAg_r_f                                                                                                                                1
SavelUr_r_f                                                                                                                                1
GolgaAg_r_f                                                                                                                                1
BotangAg_r_f                                                                                                                               1
DaboAg_r_f                                                                                                                                 1
TamaleUr_r_f                                                                                                                               1
YapeiAg_r_f                                                                                                                                1
NewLoAg_r_f                                                                                                                                1
AsanKAg_r_f                                                                                                                                1
BuipeAg_r_f                                                                                                                                1
DambUr_r_f                                                                                                                                 1
AmateAg_r_f                                                                                                                                                 1
DedesoAg_r_f                                                                                                                                                1
SataAg_r_f                                                                                                                                                  1
KpandoAg_r_f                                                                                                                                                1
KpongAg_r_f                                                                                                                                                                    1
AveyimAg_r_f                                                                                                                                                                   1
AfifeAg_r_f                                                                                                                                                                    1
AccraUr_r_f                                                                                                                                                                    1
* ----------------losses (-) ----------------------------------------------------------------------------------------------------------------------------------------------------------
Mali_uml_f
BFaso_uml_f
Benin_uml_f
Togo_uml_f
CIvoire_uml_f
Ghana_uml_f
* ----------------reservior release node rows (+) -------------------------------------------------------------------------------------------------------------------------------------
SAMEN_rel_f
LERY_rel_f
ZIGA_rel_f
BAGRE_rel_f
KOMP_rel_f
TONO_rel_f                             1
PWALU_rel_f                            1
BUI_rel_f                                                                 1
TANOSO_rel_f                                                                                              1
AMATE_rel_f                                                                                                                                1
SUBIN_rel_f                                                                                                                                1
LVOLTA_rel_f                                                                                                                                                1
KPONG_rel_f                                                                                                                                                                    1
***************************************************************************************************************************************************************************************
* Map #2:
* Enforces nonnegative flows at each use node (wet river)
* water sources are rows.  Diversion nodes are columns.
* For any column, diversion < summed flows from upstream sources (rows)
* e.g. Bagre ag use < flows from WhiteVolta headwater sources

* X(divert) < Bhd * X(inflow) + Brd * X(river)  + Bdd * X(divert) +
*             Brd * X(return) + Bgd * X(gwflow) + BLd * X(rel)

* These B coeff vectors are stacked below as the matrix, Bd
**************************************************************************************************************************************************************************************************************************************************************************** TensoAg_d_f
Table Bd_p(i, divert)  Wet river table
* -------   Col Heads are Diversion nodes -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
               BoboDUr_d_f     SamenAg_d_f    NwokuyAg_d_f    SourouAg_d_f    SorouMAg_d_f    BanUr_d_f      LSeourAg_d_f     BoromoUr_d_f     DapolaAg_d_f     GaouaUr_d_f     BagriAg_d_f     DuuliAg_d_f     NoumbAg_d_f    KanozoAg_d_f     LoumbAg_d_f    OugaUr_d_f    TensoAg_d_f   KompeUr_d_f    PorgaAg_d_f     MeteUr_d_f     DapoUr_d_f    DapaoAg_d_f    SaviliAg_d_f     NangoAg_d_f      BagrUr_d_f      BagreAg_d_f    GoogAg_d_f   TYaruAg_d_f    VeaAg_d_f    BolgaUr_d_f     TonoAg_d_f
* --------------------------------------------------------- headwater inflow node rows (+) ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BVSame_h_f         1
Sorou_h_f                                         1                 1             1                1               1              1
Nwok_h_f
Dapola_h_f
Bouga_h_f
WhiteV_h_f                                                                                                                                                                                                                           1              1
White2_h_f
DMon_h_f                                                                                                                                                                                                                                                                        1
Arli_h_f
Komp_h_f
Oti_h_f                                                                                                                                                                                                                                                                                                        1               1                1              1
Koum_h_f
RedV_h_f                                                                                                                                                                                                                                                                                                                                                                     1               1
Asibi_h_f                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             1
Nasia_h_f
Sisili_h_f
Kulpn_h_f
Subin_h_f
Tain_h_f
Poni_h_f
Bamba_h_f
Kara_h_f
Pru_h_f
Daka_h_f
Mo_h_f
Mole_h_f
Afram_h_f
Tod_h_f
* ------------------------------------------------------------ river gage node rows (+) --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
01_Samen_v_f                      1
02_Nwokuy_v_f                                     1                 1             1                1               1               1
03_Dapola_v_f                                                                                                                                       1               1               1                 1
04_Noumb_v_f                                                                                                                                                                                                         1
05_Wayen_v_f                                                                                                                                                                                                                                                     1
06_Bagre_v_f                                                                                                                                                                                                                                                                                                                                                                                                   1                1             1             1              1              1
07_Arly_v_f
08_Komp_v_f                                                                                                                                                                                                                                                                                       1
09_Mango_v_f
10_Kouma_v_f
11_Nangodi_v_f
12_Pwalugu_v_f
13_Nawuni_v_f
14_Bamboi_v_f
15_Sabari_v_f
17_Prang_v_f
16_Ekumdipe_v_f
18_AkosomUp_v_f
19_Senchi_v_f
20_Kpong_v_f
* ----------------------------------------------- diversion nodes  (-)  -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BoboDUr_d_f
SamenAg_d_f
NwokuyAg_d_f                                                        -1           -1               -1               -1            -1
SourouAg_d_f                                                                     -1               -1               -1            -1
SorouMAg_d_f                                                                                      -1               -1            -1
BanUr_d_f                                                                                                          -1            -1
LSeourAg_d_f                                                                                                                     -1
BoromoUr_d_f
DapolaAg_d_f                                                                                                                                                       -1              -1                -1
GaouaUr_d_f                                                                                                                                                                        -1                -1
BagriAg_d_f                                                                                                                                                                                          -1
DuuliAg_d_f
NoumbAg_d_f
KanozoAg_d_f                                                                                                                                                                                                                                       -1
LoumbAg_d_f
OugaUr_d_f
TensoAg_d_f
KompeUr_d_f
PorgaAg_d_f                                                                                                                                                                                                                                                                                                                     -1              -1            -1
MeteUr_d_f                                                                                                                                                                                                                                                                                                                                      -1            -1
DapoUr_d_f                                                                                                                                                                                                                                                                                                                                                    -1
DapaoAg_d_f
SaviliAg_d_f                                                                                                                                                                                                                                                                                                                                                                                 -1
NangoAg_d_f
BagrUr_d_f                                                                                                                                                                                                                                                                                                                                                                                                                    -1            -1            -1             -1             -1
BagreAg_d_f                                                                                                                                                                                                                                                                                                                                                                                                                                 -1            -1             -1             -1
GoogAg_d_f                                                                                                                                                                                                                                                                                                                                                                                                                                                -1             -1             -1
TYaruAg_d_f                                                                                                                                                                                                                                                                                                                                                                                                                                                              -1             -1
VeaAg_d_f                                                                                                                                                                                                                                                                                                                                                                                                                                                                               -1
BolgaUr_d_f
TonoAg_d_f
NZzanAg_d_f
BounaUr_d_f
WaUr_d_f
BuiAg_d_f
PwaluAg_d_f
SabariAg_d_f
TanosoAg_d_f
AkumaAg_d_f
YendiUr_d_f
SubinjAg_d_f
DipaliAg_d_f
SogoAg_d_f
LibgaAg_d_f
GolgaAg_d_f
BotangAg_d_f
SavelUr_d_f
DaboAg_d_f
TamaleUr_d_f
YapeiAg_d_f
NewLoAg_d_f
AsanKAg_d_f
BuipeAg_d_f
DambUr_d_f
AmateAg_d_f
DedesoAg_d_f
SataAg_d_f
KpandoAg_d_f
KpongAg_d_f
AveyimAg_d_f
AfifeAg_d_f
AccraUr_d_f
* --------------------------------------- return flow node rows (+) ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BoboDUr_r_f
SamenAg_r_f
NwokuyAg_r_f                                                         1            1                1               1              1
SourouAg_r_f                                                                      1                1               1              1
SorouMAg_r_f                                                                                       1               1              1
BanUr_r_f                                                                                                          1              1
LSeourAg_r_f                                                                                                                      1
BoromoUr_r_f
DapolaAg_r_f                                                                                                                                                        1              1                  1
GaouaUr_r_f                                                                                                                                                                        1                  1
BagriAg_r_f                                                                                                                                                                                           1
DuuliAg_r_f
NoumbAg_r_f
KanozoAg_r_f                                                                                                                                                                                                                                     1
LoumbAg_r_f
OugaUr_r_f
TensoAg_r_f
KompeUr_r_f
PorgaAg_r_f                                                                                                                                                                                                                                                                                                                      1               1             1
MeteUr_r_f                                                                                                                                                                                                                                                                                                                                       1             1
DapoUr_r_f                                                                                                                                                                                                                                                                                                                                                     1
DapaoAg_r_f
SaviliAg_r_f                                                                                                                                                                                                                                                                                                                                                                                  1
NangoAg_r_f
BagrUr_r_f                                                                                                                                                                                                                                                                                                                                                                                                                     1             1             1              1              1
BagreAg_r_f                                                                                                                                                                                                                                                                                                                                                                                                                                  1             1              1              1
GoogAg_r_f                                                                                                                                                                                                                                                                                                                                                                                                                                                 1              1              1
TYaruAg_r_f                                                                                                                                                                                                                                                                                                                                                                                                                                                               1              1
VeaAg_r_f                                                                                                                                                                                                                                                                                                                                                                                                                                                                                1
BolgaUr_r_f
TonoAg_r_f
WaUr_r_f
NZzanAg_r_f
BounaUr_r_f
BuiAg_r_f
PwaluAg_r_f
SabariAg_r_f
TanosoAg_r_f
AkumaAg_r_f
YendiUr_r_f
SubinjAg_r_f
DipaliAg_r_f
SogoAg_r_f
LibgaAg_r_f
SavelUr_r_f
GolgaAg_r_f
BotangAg_r_f
DaboAg_r_f
TamaleUr_r_f
YapeiAg_r_f
NewLoAg_r_f
AsanKAg_r_f
BuipeAg_r_f
DambUr_r_f
AmateAg_r_f
DedesoAg_r_f
SataAg_r_f
KpandoAg_r_f
KpongAg_r_f
AveyimAg_r_f
AfifeAg_r_f
AccraUr_r_f
* ------------------------------------------- unmeausred losses (-) -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Mali_uml_f
BFaso_uml_f
Benin_uml_f
Togo_uml_f
CIvoire_uml_f
Ghana_uml_f
* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SAMEN_rel_f
LERY_rel_f
ZIGA_rel_f
BAGRE_rel_f
KOMP_rel_f
TONO_rel_f
PWALU_rel_f
BUI_rel_f
SUBIN_rel_f
TANOSO_rel_f
AMATE_rel_f
LVOLTA_rel_f
KPONG_rel_f
*******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************
+               WaUr_d_f   NZzanAg_d_f   BounaUr_d_f     BuiAg_d_f       PwaluAg_d_f      SabariAg_d_f    TanosoAg_d_f     AkumaAg_d_f    YendiUr_d_f     SubinjAg_d_f    DipaliAg_d_f     SogoAg_d_f     LibgaAg_d_f     SavelUr_d_f      GolgaAg_d_f      BotangAg_d_f    DaboAg_d_f    TamaleUr_d_f     YapeiAg_d_f     NewLoAg_d_f    AsanKAg_d_f    BuipeAg_d_f    DambUr_d_f     AmateAg_d_f     DedesoAg_d_f    SataAg_d_f      KpandoAg_d_f     KpongAg_d_f     AveyimAg_d_f     AfifeAg_d_f    AccraUr_d_f
**********************************************************************************************************************--------------*******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************
BVSame_h_f
Sorou_h_f
Nwok_h_f
Dapola_h_f
Bouga_h_f
WhiteV_h_f
White2_h_f
DMon_h_f
Arli_h_f
Komp_h_f
Oti_h_f
Koum_h_f
RedV_h_f
Asibi_h_f
Nasia_h_f
Sisili_h_f
Kulpn_h_f
Tain_h_f
Poni_h_f
Bamba_h_f
Kara_h_f
Pru_h_f                                                                                                       1                 1
Daka_h_f                                                                                                                                        1
Subin_h_f                                                                                                                                                    1
Mo_h_f
Mole_h_f
Afram_h_f                                                                                                                                                                                                                                                                                                                                                                                   1
Tod_h_f
* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
01_Samen_v_f
02_Nwokuy_v_f
03_Dapola_v_f        1
04_Noumb_v_f                    1            1             1
05_Wayen_v_f
06_Bagre_v_f
07_Arly_v_f
08_Komp_v_f
09_Mango_v_f                                                                                  1
10_Kouma_v_f
11_Nangodi_v_f
12_Pwalugu_v_f                                                                1
13_Nawuni_v_f                                                                                                                                                                   1              1              1               1                 1                 1              1              1              1
14_Bamboi_v_f                                                                                                                                                                                                                                                                                                                 1               1              1
15_Sabari_v_f                                                                                                                                                                                                                                                                                                                                                               1              1
17_Prang_v_f
16_Ekumdipe_v_f
18_AkosomUp_v_f                                                                                                                                                                                                                                                                                                                                                                                             1               1               1
19_Senchi_v_f
20_Kpong_v_f                                                                                                                                                                                                                                                                                                                                                                                                                                                  1                1              1              1
* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BoboDUr_d_f
SamenAg_d_f
NwokuyAg_d_f
SourouAg_d_f
SorouMAg_d_f
BanUr_d_f
BoromoUr_d_f
LSeourAg_d_f
DapolaAg_d_f        -1
GaouaUr_d_f         -1
BagriAg_d_f         -1
DuuliAg_d_f         -1
NoumbAg_d_f                     -1          -1          -1
KanozoAg_d_f
LoumbAg_d_f
OugaUr_d_f
TensoAg_d_f
KompeUr_d_f
PorgaAg_d_f
MeteUr_d_f
DapaoAg_d_f
DapoUr_d_f
SaviliAg_d_f
NangoAg_d_f
BagrUr_d_f
BagreAg_d_f
GoogAg_d_f
TYaruAg_d_f
VeaAg_d_f
BolgaUr_d_f
TonoAg_d_f
WaUr_d_f
NZzanAg_d_f                                 -1          -1
BounaUr_d_f                                             -1
BuiAg_d_f
PwaluAg_d_f
SabariAg_d_f
TanosoAg_d_f                                                                                                                   -1
AkumaAg_d_f
YendiUr_d_f
SubinjAg_d_f
DipaliAg_d_f                                                                                                                                                                                  -1             -1              -1                -1                -1             -1             -1             -1
SogoAg_d_f                                                                                                                                                                                                   -1              -1                -1                -1             -1             -1             -1
LibgaAg_d_f                                                                                                                                                                                                                  -1                -1                -1             -1             -1             -1
SavelUr_d_f                                                                                                                                                                                                                                    -1                -1             -1             -1             -1
GolgaAg_d_f                                                                                                                                                                                                                                                      -1             -1             -1             -1
BotangAg_d_f                                                                                                                                                                                                                                                                    -1             -1             -1
DaboAg_d_f                                                                                                                                                                                                                                                                                     -1             -1
TamaleUr_d_f                                                                                                                                                                                                                                                                                                  -1
YapeiAg_d_f
NewLoAg_d_f                                                                                                                                                                                                                                                                                                                                   -1            -1
AsanKAg_d_f                                                                                                                                                                                                                                                                                                                                                 -1
BuipeAg_d_f
DambUr_d_f                                                                                                                                                                                                                                                                                                                                                                                -1
AmateAg_d_f
DedesoAg_d_f                                                                                                                                                                                                                                                                                                                                                                                                                -1             -1
SataAg_d_f                                                                                                                                                                                                                                                                                                                                                                                                                                 -1
KpandoAg_d_f
KpongAg_d_f                                                                                                                                                                                                                                                                                                                                                                                                                                                                     -1            -1             -1
AveyimAg_d_f                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  -1             -1
AfifeAg_d_f                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  -1
AccraUr_d_f
* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BoboDUr_r_f
SamenAg_r_f
NwokuyAg_r_f
SourouAg_r_f
SorouMAg_r_f
BanUr_r_f
BoromoUr_r_f
LSeourAg_r_f
DapolaAg_r_f         1
GaouaUr_r_f          1
BagriAg_r_f          1
DuuliAg_r_f          1
NoumbAg_r_f                      1           1           1
KanozoAg_r_f
LoumbAg_r_f
OugaUr_r_f
TensoAg_r_f
KompeUr_r_f
PorgaAg_r_f
MeteUr_r_f
DapaoAg_r_f
DapoUr_r_f
SaviliAg_r_f
NangoAg_r_f
BagrUr_r_f
BagreAg_r_f
GoogAg_r_f
TYaruAg_r_f
VeaAg_r_f
BolgaUr_r_f
TonoAg_r_f
WaUr_r_f
NZzanAg_r_f                                  1           1
BounaUr_r_f                                              1
BuiAg_r_f
PwaluAg_r_f
SabariAg_r_f
TanosoAg_r_f                                                                                                                    1
AkumaAg_r_f
YendiUr_r_f
SubinjAg_r_f
DipaliAg_r_f                                                                                                                                                                               1               1               1                 1                 1              1              1              1
SogoAg_r_f                                                                                                                                                                                                 1               1                 1                 1              1              1              1
LibgaAg_r_f                                                                                                                                                                                                                1                 1                 1              1              1              1
SavelUr_r_f                                                                                                                                                                                                                                  1                 1              1              1              1
GolgaAg_r_f                                                                                                                                                                                                                                                    1              1              1              1
BotangAg_r_f                                                                                                                                                                                                                                                                  1              1              1
DaboAg_r_f                                                                                                                                                                                                                                                                                   1              1
TamaleUr_r_f                                                                                                                                                                                                                                                                                                1
YapeiAg_r_f
NewLoAg_r_f                                                                                                                                                                                                                                                                                                                                    1             1
AsanKAg_r_f                                                                                                                                                                                                                                                                                                                                                  1
BuipeAg_r_f
DambUr_r_f                                                                                                                                                                                                                                                                                                                                                                             1
AmateAg_r_f
DedesoAg_r_f                                                                                                                                                                                                                                                                                                                                                                                                             1              1
SataAg_r_f                                                                                                                                                                                                                                                                                                                                                                                                                              1
KpandoAg_r_f
KpongAg_r_f                                                                                                                                                                                                                                                                                                                                                                                                                                                                 1             1              1
AveyimAg_r_f                                                                                                                                                                                                                                                                                                                                                                                                                                                                              1              1
AfifeAg_r_f                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              1
AccraUr_r_f
* ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Mali_uml_f
BFaso_uml_f
Benin_uml_f
Togo_uml_f
CIvoire_uml_f
Ghana_uml_f
* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SAMEN_rel_f
LERY_rel_f
ZIGA_rel_f
BAGRE_rel_f
KOMP_rel_f
TONO_rel_f
PWALU_rel_f
BUI_rel_f
SUBIN_rel_f
TANOSO_rel_f
AMATE_rel_f
LVOLTA_rel_f
KPONG_rel_f
*********************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************
display Bd_p, Bv_p;

Parameter bhh(res)  hydro reservoirs

/ 01_SAMEN_res_s      1
  04_BAGRE_res_s      1
  05_KOMP_res_s       1
  07_PWALU_res_s      1
  08_BUI_res_s        1
  12_LVOLTA_res_s     1
  13_KPONG_res_s      1
/

Parameter brr(res) recreation reserviors
/ 01_SAMEN_res_s      1
  04_BAGRE_res_s      1
  05_KOMP_res_s       1
  07_PWALU_res_s      1
  08_BUI_res_s        1
  12_LVOLTA_res_s     1/


* Map #3:
* Table relates reservoir stocks in a period to its prev periods' stocks minus releases.
* For any reservoir stock node at the column head
*   (+1) :added water at flow node -- thru releases -- takes from column's res stock (-)
*   (-1) :added water at flow node adds to column's reservoir stock
*   (  ) :added water at flow node has no effect on column's reservoir stock
* Z(res(t)) = Z(res(t-1)) + BLv * X(rel(t))+ Ber*X(evap(t))
******************************************************************************************************************************************
Table BLv_p(rel, res)      Links reservoir stocks to downstream release flows
********* Column Heads are Reservoir Stocks -- rows are release flows  *****************************************************************************************************************************************************************
********* Table = diagonal matrix for > 1 reservoir--only 1 for now    *****************************************************************************************************************************************************************
                01_SAMEN_res_s  02_LERY_res_s   03_ZIGA_res_s   04_BAGRE_res_s     05_KOMP_res_s    06_TONO_res_s   07_PWALU_res_s   08_BUI_res_s    11_SUBIN_res_s   09_TANOSO_res_s  10_AMATE_res_s  12_LVOLTA_res_s  13_KPONG_res_s
SAMEN_rel_f          1
LERY_rel_f                           1
ZIGA_rel_f                                            1
BAGRE_rel_f                                                           1
KOMP_rel_f                                                                              1
TONO_rel_f                                                                                                1
PWALU_rel_f                                                                                                               1
BUI_rel_f                                                                                                                                 1
SUBIN_rel_f                                                                                                                                                1
TANOSO_rel_f                                                                                                                                                                 1
AMATE_rel_f                                                                                                                                                                                    1
LVOLTA_rel_f                                                                                                                                                                                                     1
KPONG_rel_f                                                                                                                                                                                                                       1
****************************************************************************************************************************************************************************************************************************************

* Map #4:
* Table relates reservoir stocks to evaporation
* For any reservoir stock node at the column head
*   (-1) : reduction in reservoir stock from additional evaporation
*   (  ) : added release at a different reservoir has no effect on the base reservoir stock

Table Ber_p(evap, res)       Links reservoir evaporation to reservoir volume loss

********** Column Heads are reservoir stocks -- rows are evaporation loss flows **********************************************************************************************************************************************************
********** Table = diagonal matrix for > 1 reservoir -- only 1 for now *******************************************************************************************************************************************************************
                01_SAMEN_res_s    02_LERY_res_s    03_ZIGA_res_s   04_BAGRE_res_s   05_KOMP_res_s   06_TONO_res_s   07_PWALU_res_s   08_BUI_res_s   11_SUBIN_res_s   09_TANOSO_res_s   10_AMATE_res_s   12_LVOLTA_res_s    13_KPONG_res_s
SAMEN_evap_f          1
LERY_evap_f                            1
ZIGA_evap_f                                             1
BAGRE_evap_f                                                             1
KOMP_evap_f                                                                               1
TONO_evap_f                                                                                                1
PWALU_evap_f                                                                                                              1
BUI_evap_f                                                                                                                                  1
SUBIN_evap_f                                                                                                                                                1
TANOSO_evap_f                                                                                                                                                                1
AMATE_evap_f                                                                                                                                                                                    1
LVOLTA_evap_f                                                                                                                                                                                                    1
KPONG_evap_f                                                                                                                                                                                                                      1
******************************************************************************************************************************************************************************************************************************************

* Map #5:                                                           1
* Table relates reservoir stocks to precipitation 05_BATCH_res_s
* For any reservoir stock node at the column head
*   ( 1) : increase in reservoir stock from additional rainfall
*   (  ) : added release at a different reservoir has no effect on the base reservoir stock
* X(rain(t))=sum(res,Bra *Zar(t))
Table Bra_p(precip, res)       Links precipitation to reservoir  volume increase
********** Column Heads are reservoir stocks -- rows are evaporation loss flows **********************************************************************************************************************************************************
********** Table = diagonal matrix for > 1 reservoir -- only 1 for now *******************************************************************************************************************************************************************
                 01_SAMEN_res_s   02_LERY_res_s   03_ZIGA_res_s   04_BAGRE_res_s    05_KOMP_res_s    06_TONO_res_s   07_PWALU_res_s   08_BUI_res_s  11_SUBIN_res_s   09_TANOSO_res_s    10_AMATE_res_s    12_LVOLTA_res_s   13_KPONG_res_s
SAMEN_precip_f       1
LERY_precip_f                          1
ZIGA_precip_f                                          1
BAGRE_precip_f                                                           1
KOMP_precip_f                                                                            1
TONO_precip_f                                                                                              1
PWALU_precip_f                                                                                                              1
BUI_precip_f                                                                                                                                1
SUBIN_precip_f                                                                                                                                             1
TANOSO_precip_f                                                                                                                                                               1
AMATE_precip_f                                                                                                                                                                                   1
LVOLTA_precip_f                                                                                                                                                                                                    1
KPONG_precip_f                                                                                                                                                                                                                      1
******************************************************************************************************************************************************************************************************************************************
display BLv_p,Ber_p, Bra_p;


Parameters
B0ar_p (   res)   A-CAPAC intercept: Intercept for res area as linear fn of volume = 0 -- area
B1ar_p (   res)   A-CAPAC slope:(1st order) Slope for res area = linear fn of vol = d(area)\d(vol)
;

B0ar_p('01_SAMEN_res_s')  =      0; // > SAMEN Intercept    max vol  =  1050 million cubic meters
B1ar_p('01_SAMEN_res_s')  = .14476; // > SAMEN Slope        max area =  150 million square meters

B0ar_p('02_LERY_res_s')   =      0; // > LERY Intercept     max vol  =   360 million cubic meters
B1ar_p('02_LERY_res_s')   = .09801; // > LERY Slope         max area = 35.3 million square meters

B0ar_p('03_ZIGA_res_s')   =      0; // > ZIGA Intercept     max vol  =  200 million cubic meters
B1ar_p('03_ZIGA_res_s')   = .13100; // > ZIGA Slope         max area = 26.2 million square meters

B0ar_p('04_BAGRE_res_s')  =      0; // > BAGRE Intercept    max vol  = 1700 million cubic meters
B1ar_p('04_BAGRE_res_s')  = .07647; // > BAGRE Slope        max area = 130 million square meters

B0ar_p('05_KOMP_res_s')   =      0; // > KOMP Intercept     max vol  = 2050  million cubic meters
B1ar_p('05_KOMP_res_s')   = .10400; // > KOMP Slope         max area =213.2 million square meters

B0ar_p('06_TONO_res_s')   =      0; // > TONO Intercept     max vol  =    93 million cubic meters
B1ar_p('06_TONO_res_s')   = .20000; // > TONO Slope         max area = 18.6 million square meters

B0ar_p('07_PWALU_res_s')  =      0; // > PWALU Intercept    max vol  =  4200 million cubic meters
B1ar_p('07_PWALU_res_s')  = .09047; // > PWALU Slope        max area =  380 million square meters

B0ar_p('08_BUI_res_s')    =      0; // > BUI Intercept      max vol  =  7720 million cubic meters
B1ar_p('08_BUI_res_s')    = .05752; // > BUI Slope          max area =  444 million square meters

B0ar_p('09_TANOSO_res_s') =      0; // > TANOSO Intercept   max vol  =   125 million cubic meters
B1ar_p('09_TANOSO_res_s') = .20160; // > TANOSO Slope       max area = 25.2 million square meters

B0ar_p('10_AMATE_res_s')  =      0; // > AMATE Intercept    max vol  =   120 million cubic meters
B1ar_p('10_AMATE_res_s')  = .13667; // > AMATE Slope        max area = 16.4 million square meters

B0ar_p('11_SUBIN_res_s')  =      0; // > SUBIN Intercept    max vol  =   135 million cubic meters
B1ar_p('11_SUBIN_res_s')  = .05556; // > SUBIN Slope        max area = 7.5  million square meters

B0ar_p('12_LVOLTA_res_s') =      0; // >  LVOLTA Intercept  max vol = 148000 million cubic meters
B1ar_P('12_LVOLTA_res_s') = .05745; // >  LVOLTA Slope      max area=  8502 million square meters

B0ar_p('13_KPONG_res_s')  =      0; // > KPONG Intercept    max vol  =   200 million cubic meters
B1ar_p('13_KPONG_res_s')  = .19000; // > KPONG Slope        max area =   38 million square meters

*Be_p(evap, res) $ (ord(evap) = ord(res))  =   2.54;   //  meters per year evaporation to be
*multipled by surface area *candappa et al 2008//  this value minimzes sum of squared
*deviation between predicted and actual outflow from Lake Volta
*(All data from FAO,Obeng Asiedu 2004 ) Samen== 15,000 hectares
Table Be_p(evap, res)  Evaporation in meters per year by res to be multiplied by surface area
*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
********** Column Heads are reservoir stocks -- rows are evaporation loss flows *************************************************************************************************************************************************************
                 01_SAMEN_res_s  02_LERY_res_s  03_ZIGA_res_s  04_BAGRE_res_s    05_KOMP_res_s     06_TONO_res_s    07_PWALU_res_s   08_BUI_res_s      09_TANOSO_res_s     10_AMATE_res_s   11_SUBIN_res_s   12_LVOLTA_res_s   13_KPONG_res_s
SAMEN_evap_f        1.450
LERY_evap_f                         2.064
ZIGA_evap_f                                        2.056
BAGRE_evap_f                                                       2.004
KOMP_evap_f                                                                          1.973
TONO_evap_f                                                                                            1.983
PWALU_evap_f                                                                                                            1.134
BUI_evap_f                                                                                                                               1.771
TANOSO_evap_f                                                                                                                                               1.706
AMATE_evap_f                                                                                                                                                                  1.821
SUBIN_evap_f                                                                                                                                                                                   1.771
LVOLTA_evap_f                                                                                                                                                                                                     1.766
KPONG_evap_f                                                                                                                                                                                                                         1.578
*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
display Be_p;

Table Bp_p(precip, res)   Rainfall in meters per year by reservoir  to be multiplied by surface area
********** Column Heads are reservoir stocks -- rows are precipitation into flows A rainfall of 1 mm supplies 0.001 m3 per square meter*********************************************************************************************************
                   01_SAMEN_res_s   02_LERY_res_s    03_ZIGA_res_s   04_BAGRE_res_s   05_KOMP_res_s      06_TONO_res_s   07_PWALU_res_s   08_BUI_res_s    09_TANOSO_res_s    10_AMATE_res_s  11_SUBIN_res_s    12_LVOLTA_res_s    13_KPONG_res_s
SAMEN_precip_f        1.001
LERY_precip_f                          0.890
ZIGA_precip_f                                            0.626
BAGRE_precip_f                                                           0.962
KOMP_precip_f                                                                             0.844
TONO_precip_f                                                                                               0.801
PWALU_precip_f                                                                                                                0.871
BUI_precip_f                                                                                                                                 1.084
TANOSO_precip_f                                                                                                                                                1.231
AMATE_precip_f                                                                                                                                                                   1.209
SUBIN_precip_f                                                                                                                                                                                    1.084
LVOLTA_precip_f                                                                                                                                                                                                   1.191
KPONG_precip_f                                                                                                                                                                                                                       1.130
************************************************************************************************************************************************************************************************************************************************
display Bp_p;

Table  user_p(use, r)   use nodes and riparian combination (all large scale irr use)
                   01_Mali   02_BFaso   03_Benin   04_Togo   05_CIvoire   06_Ghana
SorouMAg_u_f          1
BanUr_u_f             1
BoboDUr_u_f                      1
SamenAg_u_f                      1
NwokuyAg_u_f                     1
SourouAg_u_f                     1
BoromoUr_u_f                     1
LSeourAg_u_f                     1
DapolaAg_u_f                     1
GaouaUr_u_f                      1
NoumbAg_u_f                      1
KanozoAg_u_f                     1
LoumbAg_u_f                      1
OugaUr_u_f                       1
TensoAg_u_f                      1
BagrUr_u_f                       1
BagreAg_u_f                      1
SaviliAg_u_f                     1
NangoAg_u_f                      1
KompeUr_u_f                      1
PorgaAg_u_f                                1
MeteUr_u_f                                 1
DapaoAg_u_f                                          1
DapoUr_u_f                                           1
NZzanAg_u_f                                                     1
BounaUr_u_f                                                     1
BagriAg_u_f                                                                 1
DuuliAg_u_f                                                                 1
WaUr_u_f                                                                    1
GoogAg_u_f                                                                  1
TYaruAg_u_f                                                                 1
VeaAg_u_f                                                                   1
TonoAg_u_f                                                                  1
BolgaUr_u_f                                                                 1
PwaluAg_u_f                                                                 1
DipaliAg_u_f                                                                1
SogoAg_u_f                                                                  1
LibgaAg_u_f                                                                 1
SavelUr_u_f                                                                 1
GolgaAg_u_f                                                                 1
BotangAg_u_f                                                                1
DaboAg_u_f                                                                  1
TamaleUr_u_f                                                                1
YapeiAg_u_f                                                                 1
YendiUr_u_f                                                                 1
SabariAg_u_f                                                                1
DambUr_u_f                                                                  1
BuiAg_u_f                                                                   1
SubinjAg_u_f                                                                1
NewLoAg_u_f                                                                 1
AsanKAg_u_f                                                                 1
BuipeAg_u_f                                                                 1
TanosoAg_u_f                                                                1
AkumaAg_u_f                                                                 1
AmateAg_u_f                                                                 1
DedesoAg_u_f                                                                1
SataAg_u_f                                                                  1
KpandoAg_u_f                                                                1
KpongAg_u_f                                                                 1
AveyimAg_u_f                                                                1
AfifeAg_u_f                                                                 1
AccraUr_u_f                                                                 1
;
display user_p;
*-------------------------------------------------------------------------------------
Table  stock_p(res, r)   stocks nodes and riparian countries combination
                    01_Mali    02_BFaso    03_Benin   04_Togo   05_CIvoire  06_Ghana
01_SAMEN_res_s                     1
02_LERY_res_s                      1
03_ZIGA_res_s                      1
04_BAGRE_res_s                     1
05_KOMP_res_s                      1
06_TONO_res_s                                                                   1
07_PWALU_res_s                                                                  1
08_BUI_res_s                                                                    1
11_SUBIN_res_s                                                                  1
09_TANOSO_res_s                                                                 1
10_AMATE_res_s                                                                  1
12_LVOLTA_res_s                                                                 1
13_KPONG_res_s                                                                  1
;
display stock_p;
*-------------------------------------------------------------------------------------------
Table turb_p(res, hydro, r)  Hydro generation and riparian country combination
                                 01_Mali  02_BFaso  03_Benin  04_Togo   05_CIvoire  06_Ghana
 01_SAMEN_res_s.01_Samen_v_f                 1
 04_BAGRE_res_s.06_Bagre_v_f                 1
 05_KOMP_res_s.08_Komp_v_f                   1
 07_PWALU_res_s.12_Pwalugu_v_f                                                          1
 08_BUI_res_s.14_Bamboi_v_f                                                             1
 12_LVOLTA_res_s.19_Senchi_v_f                                                          1
 13_KPONG_res_s.20_Kpong_v_f                                                            1

Table rivv_p (river, r)
                                01_Mali  02_BFaso  03_Benin  04_Togo   05_CIvoire  06_Ghana
    01_Samen_v_f                             1
    02_Nwokuy_v_f                            1
    03_Dapola_v_f                            1
    04_Noumb_v_f                             1
    05_Wayen_v_f                             1
    06_Bagre_v_f                             1
    07_Arly_v_f                              1
    08_Komp_v_f                              1
    09_Mango_v_f                                                 1
    10_Kouma_v_f                                                 1
    11_Nangodi_v_f                                                                      1
    12_Pwalugu_v_f                                                                      1
    13_Nawuni_v_f                                                                       1
    14_Bamboi_v_f                                                                       1
    15_Sabari_v_f                                                                       1
    17_Prang_v_f                                                                        1
    16_Ekumdipe_v_f                                                                     1
    18_AkosomUp_v_f                                                                     1
    19_Senchi_v_f                                                                       1
    20_Kpong_v_f                                                                        1


*****************************************************************************************
*  END OF BASIN GEOMETRY MAPS  THAT CONNECTS NODES
*****************************************************************************************

*****************************************************************************************
* NEXT APPEAR BASIN INFLOWS, OTHER FLOWS, FLOW RELATIONSHIPS, AND                       *
* RESERVOIR STARTING VOLUMES, SIMPLE ECONOMIC VALUES PER cubic kilometer WATER USE      *
*****************************************************************************************
* all water flows are measured in cubic meters per year
* all water stocks are measured in cubic meter instantaneous volume
*$ontext
*HYDROLOGY DATA
**************************************************************************************************
Table sourc_p(inflow,k,s) Long term average seasonal basin inflows at headwaters --rain(million m3)
*******Data are from historical headwater node flows (Data from Global Runoff Data Center Germany)
              Wet.histor_flow      Dry.histor_flow
BVSame_h_f      272.160             87.480
Sorou_h_f       506.250            168.750
Nwok_h_f        319.000            261.000
Dapola_h_f      883.500            294.500
Bouga_h_f       450.000            150.000
WhiteV_h_f      294.980              6.020
White2_h_f      679.800            420.200
DMon_h_f        100.000            100.000
Arli_h_f        178.500             31.500
Komp_h_f        293.475            265.525
Oti_h_f        2310.000           1890.000
Koum_h_f       1105.500            904.500
RedV_h_f        490.000             10.000
Asibi_h_f      1722.080            567.920
Nasia_h_f       716.250            238.750
Sisili_h_f     1294.150            696.850
Kulpn_h_f       672.560            528.440
Tain_h_f       1661.550           1359.450
Poni_h_f       1027.950            841.050
Bamba_h_f       480.150            392.850
Kara_h_f       3737.500           2012.500
Pru_h_f        1008.700            825.300
Daka_h_f        481.250            393.750
Subin_h_f       215.050            175.950
Mo_h_f          693.660            472.950
Mole_h_f        602.250            492.750
Afram_h_f      1210.000            990.000
Tod_h_f        1181.400            966.600
;
sourc_p(inflow,k,'CliStr_flow')=0.70 * sourc_p (inflow,k,'Histor_flow');//climate stress=hist inflows

display sourc_p;
*Data from Goes, B. J. M. (2005). Pre-water audit for the Volta River basin, West Africa. Ouagadougou, PAGEV Project and IUCN-BRAO.
Table sd(inflow,k,s)   standard deviation of headwater flows by headwater gauge using historical seasonal average flows (m3 per second)
                Wet.Histor_flow   Dry.Histor_flow
BVSame_h_f         13.1              12.4
Sorou_h_f           9.8               9.3
Nwok_h_f           11.4              10.8
Dapola_h_f         43.6              41.4
Bouga_h_f           5.3               5.0
WhiteV_h_f          4.8               4.5
White2_h_f         18.2              17.3
DMon_h_f            1.2               1.0
Arli_h_f            4.4               4.1
Komp_h_f            4.2               3.9
Oti_h_f            57.2              54.4
Koum_h_f          134.1             127.4
RedV_h_f           10.2               9.6
Asibi_h_f          46.7              44.3
Nasia_h_f          71.9              68.4
Sisili_h_f         68.8              65.4
Kulpn_h_f          64.3              61.1
Tain_h_f          116.9             111.1
Poni_h_f           21.5              20.4
Bamba_h_f          11.1              10.5
Kara_h_f          129.1             122.7
Pru_h_f            62.70             59.6
Daka_h_f           62.70             59.6
Subin_h_f          56.3              53.4
Mo_h_f             78.5              74.6
Mole_h_f           47.95             45.6
Afram_h_f          62.70             59.6
Tod_h_f            56.65             53.8
;

sd(inflow,k,'CliStr_flow') = 0.95* sd(inflow,k,'Histor_flow');

parameter
headflows(inflow,t,k,s)
;
Option Seed=502;            // varies random seed

headflows(inflow,t,k,'Histor_flow') = normal(sourc_p   (inflow,  k,'Histor_flow'), 0.100 * .002592  * sd(inflow,k,'Histor_flow'));
headflows(inflow,t,k,'CliStr_flow') = normal(sourc_p   (inflow,  k,'CliStr_flow'), 0.100 * .002592  * sd(inflow,k,'CliStr_flow'));

headflows(inflow,t,k,s) = max(0,headflows(inflow,t,k,s))+ eps;

display headflows;

parameter source_p(inflow,t,k,s,m,p)  source varies by year
;
source_p   (inflow,t,k,s,m,p) = headflows(inflow,t,k,s);

display source_p;

******************************************************************************************

*AGRICULTURE DATA AND LAND USE DATA TO ESTIMATE IRRIGATION BENEFITS
**************************************************AgricWaterUse***************************
Table Bu_p(i,j,k)  Per hectare crop water demand (thousand cubic meter per ha per irrigation season) =(10ths of meters depth per season)
***************************  Column Heads are Crops  *************************************
                       Rice.dry           Vege.dry      Legu.dry
*------------------------ apply node rows (+) -------------------------------------------------------------------------
SamenAg_d_f              9.00               8.42           6.76
NwokuyAg_d_f              eps               8.42           6.76
SourouAg_d_f             9.50               8.42            eps
SorouMAg_d_f            10.96                eps            eps
LSeourAg_d_f              eps               8.42           6.76
DapolaAg_d_f             9.50               8.42           6.76
BagriAg_d_f               eps               7.23           6.76
DuuliAg_d_f               eps               7.23           6.76
NoumbAg_d_f              9.50               8.42           6.76
KanozoAg_d_f              eps               7.42            eps
LoumbAg_d_f               eps               7.42            eps
SaviliAg_d_f              eps               7.42           6.76
TensoAg_d_f               eps               7.42           6.76
PorgaAg_d_f             10.78                eps            eps
DapaoAg_d_f             10.78                eps            eps
NangoAg_d_f             10.80               7.42           6.76
BagreAg_d_f             10.80               8.42           6.76
GoogAg_d_f                eps               7.23            eps
TYaruAg_d_f               eps               7.23            eps
VeaAg_d_f               10.78               7.23           6.76
TonoAg_d_f              10.50               7.42            eps
NZzanAg_d_f             10.50                eps            eps
BuiAg_d_f               10.56               7.42            eps
PwaluAg_d_f             10.50               7.23            eps
SabariAg_d_f            10.50               6.42           6.76
TanosoAg_d_f              eps               4.42            eps
AkumaAg_d_f               eps               5.42            eps
SubinjAg_d_f              eps               4.42            eps
DipaliAg_d_f             9.78               7.23           6.76
SogoAg_d_f               9.78               7.23           6.76
LibgaAg_d_f              9.50               7.42           6.76
GolgaAg_d_f              9.50               7.42           6.76
BotangAg_d_f             9.50               6.42            eps
DaboAg_d_f               9.50               7.42            eps
YapeiAg_d_f              9.50               7.42            eps
NewLoAg_d_f              9.50               5.88            eps
AsanKAg_d_f               eps               5.88            eps
BuipeAg_d_f              9.50               5.88            eps
AmateAg_d_f              9.50                eps            eps
DedesoAg_d_f              eps               4.42            eps
SataAg_d_f                eps               4.42            eps
KpandoAg_d_f              eps               5.42            eps
KpongAg_d_f             10.50               5.42            eps
AveyimAg_d_f            10.50                eps            eps
AfifeAg_d_f             10.50                eps            eps
*-------------------------- use node rows (+) ---------------------------------------------------------------------------------
SamenAg_u_f              8.86               6.28           5.52
NwokuyAg_u_f              eps               6.28           5.52
SourouAg_u_f             8.00               6.28            eps
SorouMAg_u_f             8.96                eps            eps
LSeourAg_u_f              eps               6.28           5.52
DapolaAg_u_f             8.16               6.28           5.52
BagriAg_u_f               eps               5.88           5.45
DuuliAg_u_f               eps               5.88           5.45
NoumbAg_u_f              8.16               6.28           5.52
KanozoAg_u_f              eps               4.88            eps
LoumbAg_u_f               eps               4.88            eps
SaviliAg_u_f              eps               5.28           5.52
TensoAg_u_f               eps               5.28           5.52
PorgaAg_u_f              9.11                eps            eps
DapaoAg_u_f              9.00                eps            eps
NangoAg_u_f              8.86               4.28           5.52
BagreAg_u_f              8.86               6.29           5.52
GoogAg_u_f                eps               5.88            eps
TYaruAg_u_f               eps               5.88            eps
VeaAg_u_f                9.00               5.95           5.52
TonoAg_u_f               9.00               5.28            eps
NZzanAg_u_f              9.16                eps            eps
BuiAg_u_f                9.60               5.88            eps
PwaluAg_u_f              9.00               5.88            eps
SabariAg_u_f             9.96               4.88           5.52
TanosoAg_u_f              eps               4.22            eps
AkumaAg_u_f               eps               4.28            eps
SubinjAg_u_f              eps               4.22            eps
DipaliAg_u_f             9.22               5.88           5.45
SogoAg_u_f               9.22               5.88           5.45
LibgaAg_u_f              9.16               5.28           5.52
GolgaAg_u_f              9.16               5.28           5.52
BotangAg_u_f             9.16               4.28            eps
DaboAg_u_f               8.22               5.88            eps
YapeiAg_u_f              8.22               5.88            eps
NewLoAg_u_f              8.22               4.42            eps
AsanKAg_u_f               eps               4.42            eps
BuipeAg_u_f              8.52               4.42            eps
AmateAg_u_f              8.16                eps            eps
DedesoAg_u_f              eps               4.22            eps
SataAg_u_f                eps               4.32            eps
KpandoAg_u_f              eps               5.22            eps
KpongAg_u_f              9.16               5.22            eps
AveyimAg_u_f             9.16                eps            eps
AfifeAg_u_f              9.86                eps            eps
*----------------------- return flow node rows (+) -----------------------------------------------------------------------------
SamenAg_r_f              0.14               2.14           1.24
NwokuyAg_r_f              eps               2.14           1.24
SourouAg_r_f             1.50               2.14            eps
SorouMAg_r_f             2.00                eps            eps
LSeourAg_r_f              eps               2.14           1.24
DapolaAg_r_f             1.34               2.14           1.24
BagriAg_r_f               eps               1.35           1.31
DuuliAg_r_f               eps               1.35           1.31
NoumbAg_r_f              1.34               2.14           1.24
KanozoAg_r_f              eps               2.54            eps
LoumbAg_r_f               eps               2.54            eps
TensoAg_r_f               eps               2.14           1.24
PorgaAg_r_f              1.67                eps            eps
DapaoAg_r_f              1.78                eps            eps
SaviliAg_r_f              eps               2.14           1.24
NangoAg_r_f              1.94               3.14           1.24
BagreAg_r_f              1.94               2.13           1.24
GoogAg_r_f                eps               1.35            eps
TYaruAg_r_f               eps               1.35            eps
VeaAg_r_f                1.78               1.28           1.24
TonoAg_r_f               1.50               2.14            eps
NZzanAg_r_f              1.34                eps            eps
BuiAg_r_f                0.96               1.54            eps
PwaluAg_r_f              1.50               1.35            eps
SabariAg_r_f             0.54               1.54           1.24
TanosoAg_r_f              eps               0.20            eps
AkumaAg_r_f               eps               1.14            eps
SubinjAg_r_f              eps               0.20            eps
DipaliAg_r_f             0.56               1.35           1.31
SogoAg_r_f               0.56               1.35           1.31
LibgaAg_r_f              0.34               2.14           1.24
GolgaAg_r_f              0.34               2.14           1.24
BotangAg_r_f             0.34               2.14            eps
DaboAg_r_f               1.28               1.54            eps
YapeiAg_r_f              1.28               1.54            eps
NewLoAg_r_f              1.28               1.46            eps
AsanKAg_r_f               eps               1.46            eps
BuipeAg_r_f              0.98               1.46            eps
AmateAg_r_f              1.34                eps            eps
DedesoAg_r_f              eps               0.20            eps
SataAg_r_f                eps               0.10            eps
KpandoAg_r_f              eps               0.20            eps
KpongAg_r_f              1.34               0.20            eps
AveyimAg_r_f             1.34                eps            eps
AfifeAg_r_f              0.64                eps            eps
*----------------------- umeasured losses flow node rows (+) ---ows (+) -----------------------------------------
Mali_uml_f                eps                eps            eps
BFaso_uml_f               eps                eps            eps
Benin_uml_f               eps                eps            eps
Togo_uml_f                eps                eps            eps
CIvoire_uml_f             eps                eps            eps
Ghana_uml_f               eps                eps            eps
*------------------------------------------------------------------------------------------------------------------
;

Table   Yield_p(aguse,j)   Observed Crop Mean Yield  tons per ha (proportional to ET when technology varies) //data from FAO
                        Rice                  Vege            Legu
*-------------------------- use node rows (+) ------------------------------------------------------------------------
SamenAg_u_f            3.633                 5.500            2.500
NwokuyAg_u_f                                 5.500            2.500
SourouAg_u_f           3.357                 5.500
SorouMAg_u_f           3.630
LSeourAg_u_f                                 5.500            2.500
DapolaAg_u_f           3.429                 5.500            2.500
BagriAg_u_f                                  5.639            2.511
DuuliAg_u_f                                  5.639            2.511
NoumbAg_u_f            3.429                 5.500            2.500
KanozoAg_u_f                                 6.270
LoumbAg_u_f                                  6.270
TensoAg_u_f                                  6.270            2.500
PorgaAg_u_f            3.743
DapaoAg_u_f            3.657
SaviliAg_u_f                                 6.270            2.500
NangoAg_u_f            3.429                 6.270            2.500
BagreAg_u_f            3.357                 5.497            2.500
GoogAg_u_f                                   5.639
TYaruAg_u_f                                  5.639
VeaAg_u_f              3.757                 5.614            2.500
TonoAg_u_f             3.757                 5.860
NZzanAg_u_f            3.629
BuiAg_u_f              3.357                 5.639
PwaluAg_u_f            3.357                 5.639
SabariAg_u_f           3.429                 6.451            2.500
TanosoAg_u_f                                 7.327
AkumaAg_u_f                                  6.742
SubinjAg_u_f                                 7.327
DipaliAg_u_f           3.411                 5.639            2.511
SogoAg_u_f             3.411                 5.639            2.511
LibgaAg_u_f            3.429                 5.860            2.500
GolgaAg_u_f            3.429                 5.860            2.500
BotangAg_u_f           3.429                 6.270
DaboAg_u_f             3.411                 5.639
YapeiAg_u_f            3.411                 5.639
NewLoAg_u_f            3.411                 6.209
AsanKAg_u_f                                  6.209
BuipeAg_u_f            3.411                 6.209
AmateAg_u_f            3.429
DedesoAg_u_f                                 7.327
SataAg_u_f                                   7.327
KpandoAg_u_f                                 6.773
KpongAg_u_f            3.429                 6.773
AveyimAg_u_f           3.429
AfifeAg_u_f            3.429
;
Parameter Yield_data_p (aguse, j, r);
Yield_data_p (aguse, j, r) = Yield_p(aguse,j)*user_p (aguse,r);

*-------------------------------------------------------------------------------------------------------------------------------------
Table Price1_p(aguse,j)    Crop Prices ($ US per ton)     Data from http://www.fao.org/giews/food-prices/tool/public/#/dataset/domestic
*-------------------------- use node rows (+) ----------------------------------------------------------------------------------------
                      Rice                  Vege              Legu
SamenAg_u_f           744.76               450.45            358.05
NwokuyAg_u_f                               417.08            318.36
SourouAg_u_f          736.71               417.08
SorouMAg_u_f          661.12
LSeourAg_u_f                               435.50            327.28
DapolaAg_u_f          744.76               450.45            358.05
BagriAg_u_f                                500.00            454.90
DuuliAg_u_f                                500.00            454.90
NoumbAg_u_f           744.76               450.45            358.05
KanozoAg_u_f                               459.75
LoumbAg_u_f                                459.75
TensoAg_u_f                                450.50            341.19
PorgaAg_u_f           821.54
DapaoAg_u_f           720.81
SaviliAg_u_f                               450.50            341.19
NangoAg_u_f           790.67               480.76            344.47
BagreAg_u_f           790.67               480.76            344.47
GoogAg_u_f                                 500.00
TYaruAg_u_f                                500.00
VeaAg_u_f             801.71               500.00            454.90
TonoAg_u_f            801.71               500.00
NZzanAg_u_f           681.85
BuiAg_u_f             716.98               500.00
PwaluAg_u_f           801.71               510.00
SabariAg_u_f          716.98               500.00            485.13
TanosoAg_u_f                               540.00
AkumaAg_u_f                                540.00
SubinjAg_u_f                               540.00
DipaliAg_u_f          801.71               500.00            454.90
SogoAg_u_f            801.71               500.00            454.90
LibgaAg_u_f           801.71               500.00            454.90
GolgaAg_u_f           801.71               500.00            454.90
BotangAg_u_f          801.71               500.00
DaboAg_u_f            716.98               500.00
YapeiAg_u_f           716.98               500.00
NewLoAg_u_f           799.29               540.00
AsanKAg_u_f                                540.00
BuipeAg_u_f           799.29               540.00
AmateAg_u_f           799.29
DedesoAg_u_f                               540.00
SataAg_u_f                                 540.00
KpandoAg_u_f                               500.89
KpongAg_u_f           990.81               500.89
AveyimAg_u_f          990.81
AfifeAg_u_f           990.81
;

Parameter Price_p(aguse,j);

Price_p(aguse,j)=Price1_p(aguse,j);


Parameter Price_data_p (aguse, j, r);
Price_data_p (aguse, j, r) = Price_p(aguse,j)*user_p (aguse,r);
*-----------------------------------------------------------------------------------------------------------------------------------------------

Parameter Cost_p(aguse,j);

Cost_p(aguse,j) = 0.80 * (Price_p(aguse,j) * Yield_p(aguse,j)); // poor data on cost set = to 80% of gross revenue

Display  Price_data_p, Cost_p;

Parameter Net_rev_p(aguse,j)    US dollars per ha
;
Net_rev_p(aguse,j)=(Price_p(aguse,j) * Yield_p(aguse,j))- Cost_p(aguse,j);//net revenue per hectare
Display Net_rev_p;
*-----------------------------------------------------------------------------------------------------------------------------------------------
*                       Including New Irrigated Land to be added as a result of the development of Samendeni, Bagre and Pwalugu dams
Parameter LandRHS_p (aguse)  2030 Available irrigated land area by nodes (thousand hectares)(MCartney et al 2012 and Volta Diagnostics UNEF 2013)
/
SamenAg_u_f       21.000
NwokuyAg_u_f       3.330
SourouAg_u_f       4.990
SorouMAg_u_f      11.300
LSeourAg_u_f      10.110
DapolaAg_u_f       1.362
BagriAg_u_f        0.100
DuuliAg_u_f        0.150
NoumbAg_u_f        0.250
KanozoAg_u_f       5.319
LoumbAg_u_f        1.000
TensoAg_u_f        0.200
PorgaAg_u_f       10.503
DapaoAg_u_f       12.400
SaviliAg_u_f       0.700
NangoAg_u_f        0.184
BagreAg_u_f       30.000
GoogAg_u_f         0.200
TYaruAg_u_f        0.200
VeaAg_u_f          1.197
TonoAg_u_f         3.840
NZzanAg_u_f       18.361
BuiAg_u_f         30.000
PwaluAg_u_f       20.000
SabariAg_u_f       2.980
TanosoAg_u_f       0.116
AkumaAg_u_f        1.000
SubinjAg_u_f       0.121
DipaliAg_u_f       0.180
SogoAg_u_f         0.130
LibgaAg_u_f        0.040
GolgaAg_u_f        0.100
BotangAg_u_f       0.570
DaboAg_u_f         0.500
YapeiAg_u_f        0.200
NewLoAg_u_f        0.245
AsanKAg_u_f        0.144
BuipeAg_u_f        0.118
AmateAg_u_f        0.202
DedesoAg_u_f       0.400
SataAg_u_f         0.056
KpandoAg_u_f       0.356
KpongAg_u_f        3.028
AveyimAg_u_f       0.550
AfifeAg_u_f        0.950
/
;

Table land_crop_pct(aguse, j) Land to crop in each irrigated area in percent terms
                     Rice            Vege          Legu
*-------------------------- use node rows (+) ----------------------------
SamenAg_u_f          0.90            0.10           eps
NwokuyAg_u_f          eps            0.49          0.51
SourouAg_u_f         0.49            0.51           eps
SorouMAg_u_f         1.00             eps           eps
LSeourAg_u_f          eps            0.50          0.50
DapolaAg_u_f         0.07            0.90          0.03
BagriAg_u_f           eps            0.80          0.20
DuuliAg_u_f           eps            0.80          0.20
NoumbAg_u_f          0.17            0.48          0.35
KanozoAg_u_f          eps            1.00           eps
LoumbAg_u_f           eps            1.00           eps
TensoAg_u_f           eps            0.70          0.30
PorgaAg_u_f          1.00             eps           eps
DapaoAg_u_f          1.00             eps           eps
SaviliAg_u_f          eps            0.70          0.30
NangoAg_u_f          0.31            0.32          0.37
BagreAg_u_f          0.42            0.42          0.16
GoogAg_u_f            eps            1.00           eps
TYaruAg_u_f           eps            1.00           eps
VeaAg_u_f            0.40            0.40          0.20
TonoAg_u_f           0.50            0.50           eps
NZzanAg_u_f          1.00             eps           eps
PwaluAg_u_f          0.75            0.25           eps
BuiAg_u_f            0.40            0.60           eps
SabariAg_u_f         0.50            0.48          0.02
TanosoAg_u_f          eps            1.00           eps
AkumaAg_u_f           eps            1.00           eps
SubinjAg_u_f          eps            1.00           eps
DipaliAg_u_f         0.30            0.60          0.10
SogoAg_u_f           0.40            0.50          0.10
LibgaAg_u_f          0.40            0.40          0.20
GolgaAg_u_f          0.50            0.20          0.30
BotangAg_u_f         0.40            0.60           eps
DaboAg_u_f           0.30            0.70           eps
YapeiAg_u_f          0.50            0.50           eps
NewLoAg_u_f          0.40            0.60           eps
AsanKAg_u_f           eps            1.00           eps
BuipeAg_u_f          0.10            0.90           eps
AmateAg_u_f          1.00             eps           eps
DedesoAg_u_f          eps            1.00           eps
SataAg_u_f            eps            1.00           eps
KpandoAg_u_f          eps            1.00           eps
KpongAg_u_f          0.90            0.10           eps
AveyimAg_u_f         1.00             eps           eps
AfifeAg_u_f          1.00             eps           eps
;

Parameter RHS_land_by_crop(aguse,j);//available irrigated land by crop
RHS_land_by_crop(aguse,j) = LandRHS_p(aguse) * land_crop_pct(aguse,j);
display RHS_land_by_crop;

parameter RHS_land_by_crop_ctry_p(aguse,r,j);//available land by country
RHS_land_by_crop_ctry_p(aguse,r,j) = RHS_land_by_crop(aguse,j) * user_p(aguse,r);
display RHS_land_by_crop_ctry_p;


Table ir_p(aguse,m)  irrigation dummy variable
                  Plus_PMD_SMD
SorouMAg_u_f         1
SamenAg_u_f          1
NwokuyAg_u_f         1
SourouAg_u_f         1
LSeourAg_u_f         1
DapolaAg_u_f         1
NoumbAg_u_f          1
KanozoAg_u_f         1
LoumbAg_u_f          1
TensoAg_u_f          1
BagreAg_u_f          1
SaviliAg_u_f         1
NangoAg_u_f          1
PorgaAg_u_f          1
DapaoAg_u_f          1
NZzanAg_u_f          1
BagriAg_u_f          1
DuuliAg_u_f          1
GoogAg_u_f           1
TYaruAg_u_f          1
VeaAg_u_f            1
TonoAg_u_f           1
BuiAg_u_f            1
PwaluAg_u_f          1
SubinjAg_u_f         1
DipaliAg_u_f         1
SogoAg_u_f           1
LibgaAg_u_f          1
DaboAg_u_f           1
YapeiAg_u_f          1
SabariAg_u_f         1
NewLoAg_u_f          1
AsanKAg_u_f          1
BuipeAg_u_f          1
TanosoAg_u_f         1
AkumaAg_u_f          1
AmateAg_u_f          1
DedesoAg_u_f         1
SataAg_u_f           1
KpandoAg_u_f         1
KpongAg_u_f          1
AveyimAg_u_f         1
AfifeAg_u_f          1

parameter RHS_land_by_crop_ctry_r_p(aguse,r,m);
RHS_land_by_crop_ctry_r_p(aguse,r,m)=sum((j),RHS_land_by_crop_ctry_p(aguse,r,j)*ir_p(aguse,m));
display RHS_land_by_crop_ctry_r_p;


parameter RHS_p(aguse,t,r,m);
RHS_p(aguse,t,r,m)= RHS_land_by_crop_ctry_r_p(aguse,r,m);
display RHS_p;

**********************************************IrrigationUse_Ends*************************************************************************


**********************************************Hydropwer_Begins***************************************************************************
*HYDROPOWER DATA                                                                                                                        *
*****************************************************************************************************************************************
*

Table dam_cost(r,m)     Project Cost (cost of building and maintaining and operating dam and irrigation development cost in million $)
                        Plus_PMD_SMD     // Project cost excludes $55 million for a 50MW solar PV component
  01_Mali                    0
  02_BFaso                  105
  03_Benin                   0
  04_Togo                    0
  05_CIvoire                 0
  06_Ghana                  938
*https://www.ghanastar.com/news/700m-needed-to-build-pwalugu-multi-purpose-dam-sada/
*https://starrfm.com.gh/2019/04/work-begins-on-pwalugu-multipurpose-dam/*By Starrfmonline -April 20, 2019
*https://constructionreviewonline.com/2019/02/ghanas-cabinet-approves-us-700m-for-pwalugu-dam-project/*By kenneth Mwenda - Feb 22, 2019
*https://www.ghanaweb.com/GhanaHomePage/NewsArchive/Work-begins-on-Pwalugu-multipurpose-dam-740022
*https://www.ghanaianews.com/2019/04/24/vra-holds-engagement-on-pwalugu-multi-purpose-dam-project/
*https://www.graphic.com.gh/features/features/vra-starts-implementation-of-the-pwalugu-multi-purpose-dam.html
*https://allafrica.com/stories/201904160711.html
*https://www.hydropower.org/country-profiles/ghana
*https://africa-energy-portal.org/news/burkina-faso-samendeni-hydroelectric-dam-officially-operational-bama

Parameter dam_cost_p (r,m); // Total Estimated Project Cost
dam_cost_p (r,m)= 1.0*dam_cost(r,m);
Display dam_cost_p;

TABLE power_p(res,m)       Power production dummy variable
                           Plus_PMD_SMD
  01_SAMEN_res_s              1
  04_BAGRE_res_s              1
  05_KOMP_res_s               1
  07_PWALU_res_s              1
  08_BUI_res_s                1
  12_LVOLTA_res_s             1
  13_KPONG_res_s              1

Table teff_p(res,m)      Turbine efficiency parameter
                         Plus_PMD_SMD
  01_SAMEN_res_s           .85
  04_BAGRE_res_s           .85
  05_KOMP_res_s            .85
  07_PWALU_res_s           .85
  08_BUI_res_s             .85
  12_LVOLTA_res_s          .90
  13_KPONG_res_s           .85

Table capacity_p (res,m)   Reservoir maximum capacity in million cubic meters  (Reserviors with capacity>90Mm3)
                           Plus_PMD_SMD
  01_SAMEN_res_s             1050
  02_LERY_res_s               360
  03_ZIGA_res_s               200
  04_BAGRE_res_s             1700
  05_KOMP_res_s              2050
  06_TONO_res_s                93
  07_PWALU_res_s             4237
  08_BUI_res_s              12570
  09_TANOSO_res_s             125
  10_AMATE_res_s              120
  11_SUBIN_res_s              135
  12_LVOLTA_res_s          148000
  13_KPONG_res_s              200

Parameters
z0_p  (res  )                Initial reservoir levels at stock nodes
zmax_p(res,t,k,s,m,p)            Maximum reservoir capcity
;
z0_p  ('01_SAMEN_res_s'     )    =    735; // Samendeni reservior starting volume  (75% of maximum storage)(million cubic meters)
z0_p  ('02_LERY_res_s'      )    =    252; // Lery reservior starting volume  (70% of maximum storage)(million cubic meters)
z0_p  ('03_ZIGA_res_s'      )    =    196; // Ziga reservior starting volume  (98% of maximum storage)(million cubic meters)
z0_p  ('04_BAGRE_res_s'     )    =    754; // Bagre reservior starting volume  (data from Obeng Asiedu 2004)(million cubic meters)
z0_p  ('05_KOMP_res_s'      )    =   1845; // Kompienga reservior starting volume (90% of maximum storage)(million cubic meters)
z0_p  ('06_TONO_res_s'      )    =     90; //Tono reservior starting volume (data from GIDA)(million cubic meters)
z0_p  ('07_PWALU_res_s'     )    =  0.001; // Pwalugu reservior starting volume (0% of maximum storage)(million cubic meters) starts empty
z0_p  ('08_BUI_res_s'       )    =   6004; // Bui reservior starting volume(70% of maximum storage)(million cubic meters)
z0_p  ('09_TANOSO_res_s'    )    =    112; //87.5; 125;// Tanoso reservior starting volume (70% of maximum storage)(million cubic meters)
z0_p  ('10_AMATE_res_s '     )    =    108;  //120 Amate reservior starting volume     (70% of maximum storage)(million cubic meters)
z0_p  ('11_SUBIN_res_s'     )    =    095; // 135;// Subinja reservior starting volume(70% of maximum storage)(million cubic meters)
z0_p  ('12_LVOLTA_res_s'    )    = 112725;//88800//Volta  reservior starting volume (70% of maximum storage)(million cubic meters)
z0_p  ('13_KPONG_res_s'     )    =    200;//Kpong reservior starting volume (100% maximum storage)(million cubic meters)(data fro Obeng Asiedu 2004)
;
zmax_p (res,t,k,s,m,p) = capacity_p(res,m);
Display zmax_p;

Parameters
Hydroprice_p ( t,k,r,s,m,p)   Average hydroprices;

hydroprice_p( t,k,'02_BFASO',s,m,p) = .25;
hydroprice_p( t,k,'06_Ghana',s,m,p) = .17;
;
Display hydroprice_p;

$ontext
Parameter
Hydroprice_p(res,t,k,s,m,p)    Average hydroprices; //Note that price of $ per kwh= $ millions per gwh  per year(https://prevodyonline.eu/en/energy-price.html)

hydroprice_p('01_SAMEN_res_s' ,t,k,s,m,p) = .25;// max hydro price SAMENDENI dam  (highest in the West African sub-region)
hydroprice_p('04_BAGRE_res_s' ,t,k,s,m,p) = .25;// max hydro price BAGRE dam  (highest in the West African sub-region)
hydroprice_p('05_KOMP_res_s'  ,t,k,s,m,p) = .25;// max hydro price KOMPIENGA dam (data from World Bank
hydroprice_p('07_PWALU_res_s' ,t,k,s,m,p) = .17;// max hydro price BUI dam
hydroprice_p('08_BUI_res_s'   ,t,k,s,m,p) = .17;// max hydro price BUI dam
hydroprice_p('12_LVOLTA_res_s',t,k,s,m,p) = .17;// max hydro price LVOLTA dam
hydroprice_p('13_KPONG_res_s' ,t,k,s,m,p) = .17;// max hydro price KPONG dam
*Average Grid Electricity End User Tariff
*data from Energy Commission Ghana, Electricity Company of Ghana and SONABEL-Electricity company in Burkina Faso
*http://documents.worldbank.org/curated/en/889901551115559831/pdf/Concept-Project-Information-Document-PID-BURKINA-FASO-ELECTRICITY-ACCESS-PROJECT-P166785.pdf
$offtext

*Pwa Dam height Groves, D., Mao, Z., Liden, R., Strzepek, K. M., Lempert, R., Brown, C., ... & Bloom, E. (2015).
*Adaptation to Climate Change i n Project Design. Enhancing the Climate Resilience of Africa?s Infrastructure, 131.

Parameters
h0_p(res, t,k,s,m,p)      Maximum dam hydraulic head in meters (net head for hydropower);
h0_p('01_SAMEN_res_s', t,k,s,m,p)   = 24;// max head SAMENDENI reservior
h0_p('04_BAGRE_res_s', t,k,s,m,p)   = 41;// max head BAGRE reservior  https://www.pietrangeli.com/dam-bagre-earthfill-dam-burkina-faso-africa
h0_p('05_KOMP_res_s',  t,k,s,m,p)   = 50.5; // max head KOMPIENGA reservior//http://www.ecowrex.org/eg/kompienga
h0_p('07_PWALU_res_s', t,k,s,m,p)   = 36.2; // max head Pwalu reservior
h0_p('08_BUI_res_s',   t,k,s,m,p)   = 88; // max head BUI reservior
h0_p('12_LVOLTA_res_s',t,k,s,m,p)   = 84;// max head LVOLTA reservior   data from FAO
h0_p('13_KPONG_res_s', t,k,s,m,p)   = 20; // max head KPONG reservior   data from FAO
;
display h0_p;

Table intercept_p(res,m) slope head_storage_equations cofficeints
                             Plus_PMD_SMD
  01_SAMEN_res_s              30.000
  04_BAGRE_res_s              12.825
  05_KOMP_res_s               27.000
  07_PWALU_res_s              15.501
  08_BUI_res_s                30.830
  12_LVOLTA_res_s             13.896
  13_KPONG_res_s              11.600


Table exp_p(res, m) exponent head_storage_equation's cofficeints
                            Plus_PMD_SMD
   01_SAMEN_res_s             0.115
   04_BAGRE_res_s             0.199
   05_KOMP_res_s              0.112
   07_PWALU_res_s             0.105
   08_BUI_res_s               0.111
   12_LVOLTA_res_s            0.185
   13_KPONG_res_s             0.138
*.102
Table  evapdist_p(res,k)  allocates annual evaporation among seasons for model evaporation variable
                    Wet       Dry
01_SAMEN_res_s     .42       .58
02_LERY_res_s      .43       .57
03_ZIGA_res_s      .45       .55
04_BAGRE_res_s     .46       .54
05_KOMP_res_s      .41       .59
06_TONO_res_s      .41       .59
07_PWALU_res_s     .40       .60
08_BUI_res_s       .49       .51
11_SUBIN_res_s     .50       .50
09_TANOSO_res_s    .50       .50
10_AMATE_res_s     .50       .50
12_LVOLTA_res_s    .50       .50
13_KPONG_res_s     .50       .50

Table  Prepdist_p(res,k)  allocates annual precipitation among seasons for model precipitation variable
                   Wet        Dry
01_SAMEN_res_s    .85        .15
02_LERY_res_s     .97        .03
03_ZIGA_res_s     .95        .05
04_BAGRE_res_s    .95        .05
05_KOMP_res_s     .98        .02
06_TONO_res_s     .89        .11
07_PWALU_res_s    .91        .09
08_BUI_res_s      .90        .10
11_SUBIN_res_s    .90        .10
09_TANOSO_res_s   .90        .10
10_AMATE_res_s    .90        .10
12_LVOLTA_res_s   .90        .10
13_KPONG_res_s    .90        .10
**********************************************Hydropwer_Ends*****************************************************************************

*********************************************UrbanWaterUse_Begins************************************************************************
*URBAN (DOMESTIC) WATER USE (ABSTRACTION) DATA                                                                                          *
*****************************************************************************************************************************************
Table Bmu_p(urdivert, uruse)      Table defines consumptive use for urban
* -------------------------  Use nodes -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                  BanUr_u_f        BoboDUr_u_f   BoromoUr_u_f   GaouaUr_u_f   OugaUr_u_f   BagrUr_u_f   KompeUr_u_f   MeteUr_u_f    DapoUr_u_f     BounaUr_u_f     WaUr_u_f   BolgaUr_u_f   SavelUr_u_f   TamaleUr_u_f   YendiUr_u_f   DambUr_u_f   AccraUr_u_f
* ------------------------ apply nodes (+) --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 BanUr_d_f         0.70
 BoboDUr_d_f                           0.90
 BoromoUr_d_f                                         0.90
 GaouaUr_d_f                                                        0.80
 OugaUr_d_f                                                                      0.85
 BagrUr_d_f                                                                                   0.79
 KompeUr_d_f                                                                                                0.69
 MeteUr_d_f                                                                                                             0.97
 DapoUr_d_f                                                                                                                            0.90
 BounaUr_d_f                                                                                                                                          0.60
 WaUr_d_f                                                                                                                                                            0.69
 BolgaUr_d_f                                                                                                                                                                      0.70
 SavelUr_d_f                                                                                                                                                                                   0.69
 TamaleUr_d_f                                                                                                                                                                                                0.69
 YendiUr_d_f                                                                                                                                                                                                                0.70
 DambUr_d_f                                                                                                                                                                                                                                0.80
 AccraUr_d_f                                                                                                                                                                                                                                            0.69
*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;
Display Bmu_p;

Table Bmr_p(urdivert, urreturn)   Table defines return flow to river (surface flow)
* -------------------------  Return flow nodes ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                    BanUr_r_f      BoboDUr_r_f   BoromoUr_r_f   GaouaUr_r_f   OugaUr_r_f   BagrUr_r_f   KompeUr_r_f   MeteUr_r_f    DapoUr_r_f     BounaUr_r_f     WaUr_r_f   BolgaUr_r_f   SavelUr_r_f    TamaleUr_r_f   YendiUr_r_f    DambUr_r_f   AccraUr_r_f
* ------------------------ apply nodes (+) ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 BanUr_d_f           0.30
 BoboDUr_d_f                          0.10
 BoromoUr_d_f                                        0.10
 GaouaUr_d_f                                                        0.20
 OugaUr_d_f                                                                      0.15
 BagrUr_d_f                                                                                   0.21
 KompeUr_d_f                                                                                                0.31
 MeteUr_d_f                                                                                                             0.03
 DapoUr_d_f                                                                                                                            0.10
 BounaUr_d_f                                                                                                                                          0.40
 WaUr_d_f                                                                                                                                                            0.31
 BolgaUr_d_f                                                                                                                                                                    0.30
 SavelUr_d_f                                                                                                                                                                                  0.31
 TamaleUr_d_f                                                                                                                                                                                               0.31
 YendiUr_d_f                                                                                                                                                                                                                0.30
 DambUr_d_f                                                                                                                                                                                                                                0.20
 AccraUr_d_f                                                                                                                                                                                                                                            0.31
*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;

Display Bmr_p;

Bu_p(agreturn,j,k) = sum(agdivert, Bu_p(agdivert,j,k) * ID_dr_p(agdivert,agreturn)) - sum(aguse, Bu_p(aguse,j,k) * ID_ur_p(aguse,agreturn));

Display Bu_p;

Parameter  chk_aguse_p(aguse,j,k)  checks to see if agdivert = aguse + agreturn
;
chk_aguse_p(aguse,j,k)  =  sum(agdivert, Bu_p(agdivert,j,k) * ID_du_p(agdivert,aguse)) - [Bu_p(aguse,j,k) + sum(agreturn, Bu_p(agreturn,j,k) * ID_ru_p(agreturn,aguse))] + eps;

Display chk_aguse_p;

Parameter use_p(uruse)    Volta water delivery into supply network per hh per year  (cubic meters per household per season)
*data from Goes 2005 'Pre-water audit for the Volta Basin, West Africa', GWC, ONEA and Obeng Asiedu 2004
/BanUr_u_f          115.57
 BoboDUr_u_f        130.33
 BoromoUr_u_f        18.40
 GaouaUr_u_f         18.40
 OugaUr_u_f         185.45
 BagrUr_u_f          18.48
 KompeUr_u_f         11.44
 MeteUr_u_f         116.61
 DapoUr_u_f         113.91
 BounaUr_u_f        135.00
 WaUr_u_f           110.86
 BolgaUr_u_f         11.82
 SavelUr_u_f         10.90
 TamaleUr_u_f       144.49
 YendiUr_u_f         12.27
 DambUr_u_f          15.43
 AccraUr_u_f        175.15
/

Parameter pop_p(uruse)      Urban population  in millions
*data from World Population Review with the World Population Prospects (2017 Revision) - United Nations population estimates and projections as source
*http://worldpopulationreview.com/countries/burkina-faso-population/ (assessed May 23, 2018) and http://www.statsghana.gov.gh
/BanUr_u_f            .271
 BoboDUr_u_f          .772
 BoromoUr_u_f         .123
 GaouaUr_u_f          .091
 OugaUr_u_f          1.087
 BagrUr_u_f           .015
 KompeUr_u_f          .129
 MeteUr_u_f           .214
 DapoUr_u_f           .715
 BounaUr_u_f          .215
 WaUr_u_f             .107
 BolgaUr_u_f          .132
 SavelUr_u_f          .038
 TamaleUr_u_f         .371
 YendiUr_u_f          .052
 DambUr_u_f           .027
 AccraUr_u_f         2.270
/

*The possible reasons for the large household sizes in the
*region are polygyny, high fertility and the common practice of nuclear and extended family members living together.

Parameter HHsize_p(uruse)   People per household  (Average household size)
* I used population per household http://www.statsghana.gov.gh/docfiles/2010_District_Report/Greater%20Accra/AMA.pdf
/BanUr_u_f         7
 BoboDUr_u_f       5
 BoromoUr_u_f      5
 GaouaUr_u_f       6
 OugaUr_u_f        6
 BagrUr_u_f        6
 KompeUr_u_f       6
 MeteUr_u_f        5
 DapoUr_u_f        6
 BounaUr_u_f       5
 WaUr_u_f          6
 BolgaUr_u_f       4
 SavelUr_u_f       6
 TamaleUr_u_f      6
 YendiUr_u_f       6
 DambUr_u_f        6
 AccraUr_u_f       4
/
* Average Number of households by urban node (in millions).Note that the scal is the average number of households
Parameter scal_p (uruse)    Millions of households
;
scal_p(uruse)=(pop_p(uruse)/HHsize_p(uruse));

Display scal_p;

Parameter growth_p(uruse)
/BanUr_u_f        0.03
 BoboDUr_u_f      0.03
 BoromoUr_u_f     0.02
 GaouaUr_u_f      0.02
 OugaUr_u_f       0.03
 BagrUr_u_f       0.02
 KompeUr_u_f      0.02
 MeteUr_u_f       0.02
 DapoUr_u_f       0.02
 BounaUr_u_f      0.03
 WaUr_u_f         0.03
 BolgaUr_u_f      0.03
 SavelUr_u_f      0.02
 TamaleUr_u_f     0.03
 YendiUr_u_f      0.02
 DambUr_u_f       0.02
 AccraUr_u_f      0.02
/

Parameter scale_p(uruse,t,k,s,m,p)  Acccounts for growing population of cities annual population growth
;

scale_p(uruse,t,k,s,m,p) = ((1 + growth_p (uruse)) ** (ord(t)*card(k)-1))*scal_p(uruse);


Display scale_p;

Parameter P_elas_p(uruse) Urban price elasticity of demand for treated urban water - (unitless)

/BanUr_u_f       -0.9
 BoboDUr_u_f     -0.9
 BoromoUr_u_f    -0.9
 GaouaUr_u_f     -0.9
 OugaUr_u_f      -0.9
 BagrUr_u_f      -0.9
 KompeUr_u_f     -0.9
 MeteUr_u_f      -0.9
 DapoUr_u_f      -0.9
 BounaUr_u_f     -0.9
 WaUr_u_f        -0.9
 BolgaUr_u_f     -0.9
 SavelUr_u_f     -0.9
 TamaleUr_u_f    -0.9
 YendiUr_u_f     -0.9
 DambUr_u_f      -0.9
 AccraUr_u_f     -0.9
/
* Modeling water demand when households have multiple sources of water Coulibaly et al 2014
Parameter Ur_price_p(uruse) Urban water price ($ per cubic meter produced per year) data from ONEA-BFASO and Water Resources Commission-GHANA
/BanUr_u_f         0.39
 BoboDUr_u_f       0.39
 BoromoUr_u_f      0.39
 GaouaUr_u_f       0.35
 OugaUr_u_f        0.39
 BagrUr_u_f        0.31
 KompeUr_u_f       0.31
 MeteUr_u_f        0.35
 DapoUr_u_f        0.35
 BounaUr_u_f       0.30
 WaUr_u_f          0.30
 BolgaUr_u_f       0.30
 SavelUr_u_f       0.30
 TamaleUr_u_f      0.30
 YendiUr_u_f       0.30
 DambUr_u_f        0.30
 AccraUr_u_f       0.20
/
;
**The cost of urban water service delivery in Ghana**
**Ghanaian Journal of Economics, Dec 2014**

Parameter Ben_u_p(uruse,*)         Per household urban water use benefit
;
Ben_u_p(uruse, 'intercept') =   0.00;
Ben_u_p(uruse, 'linear')    =         ur_price_p(uruse) * (P_elas_p(uruse) - 1) / P_elas_p(uruse);// intercept of price depends on Urban dd fn = choke price
Ben_u_p(uruse, 'quadratic') =   0.5 * ur_price_p(uruse) / (P_elas_p(uruse) *        use_p(uruse));// 0.5 * slope of price depends on Urban dd fn = dp/dq

Display Ben_u_p;
**************************************************UrbanWaterUseEnds************************************************************************************************

*RECREATION DATA
*************************************************RecreationBenefitsBegin**************************************************************************************** **
Parameters

MBe_p(res)     coefficient for reservoir based recreation multiplied by square root storage volume for total benefits $million per m^3 storage
*0.0081 million per million cubic meter storage/thus, recreation benefits is in Million dollars
/ 01_SAMEN_res_s     0.001
  04_BAGRE_res_s     0.001
  05_KOMP_res_s      0.001
  07_PWALU_res_s     0.001
  08_BUI_res_s       0.001
  12_LVOLTA_res_s    0.002/
* Assume each additional million cubic meter storage generate $100
* 8.10 per 1000 cubic meter for recreation or   See USACE study published in WRR, 1995 by Ward, Henderson, Roach
* on recreational values of water in Ca Drought, for $10 per acre foot at Isabella Lake when 20% full
* annual recreational values per acre-foot (1234 m 3) of water vary from $6 at Pine Flat Reservoir to more than $600 at Success Lake
* $100 per 1000000 cubic meters
elas_rec_p(res)      coefficient for reservoir based recreation multiplied by square root storage volume for total benefits $100 per bcm storage
/ 01_SAMEN_res_s     1.00
  04_BAGRE_res_s     1.00
  05_KOMP_res_s      1.00
  07_PWALU_res_s     1.00
  08_BUI_res_s       1.00
  12_LVOLTA_res_s    1.00/
;
* Reservoir Recreation benefits are a function of reservoir volume


************************************************RecreationBenefitsEnds********************************************************************************************

*FLOOD CONTROL DATA
******************************************************************************************************************************************************************
*Parameter Value_p (river)  in million dollars  (Estimated annual damage assessed value per flood event based on 2007 floods)
*/08_Pwalugu_v_f        10/    Reservoir simulations showed that around 70% of the yearly floods can be controlled by the dam even without any specific operation rule.

Table  Value_p (river,m)
                       Plus_PMD_SMD
12_Pwalugu_v_f            15.9
;
* Reservoir simulations showed that around 70% of the yearly flood damage values can be controlled by the dam even without any specific operation rule (Mosello et al 2017).
* Estimated annual damage assessed value per flood event based on 2007 floods
* data from https://reliefweb.int/report/ghana/ghana-floods-displace-nearly-275000-little-known-disaster

Parameter Constant (river)
/12_Pwalugu_v_f   36.29049/

****************************************************************************************************************************************************************************
Parameter rho_p   discount rate
/0.05/

Parameter df_p(t) discount factor
;
df_p(t) = 1/(1+rho_p) ** (ord(t) - 1);
*
Display df_p;
****************************************************************************************************************************************************************************
* POTENTIAL WATER AND POWER TRADE AGREEMENT                                                                                                                                                                        *
****************************************************************************************************************************************************************************
*Potential hydropower trade with treaty in place combination - Discount to Upstream Countries  Based on Current power trade

Parameters

B0_demand_price_p(r)
/01_Mali     .201
 02_BFASO    .260
 03_Benin    .2005
 04_Togo     .206
 05_CIvoire  .200
 06_Ghana    .180
/

B1_demand_price_p(r)
/01_Mali      -.0001
 02_BFASO     -.0001
 03_Benin     -.0001
 04_Togo      -.0001
 05_CIvoire   -.0001
 06_Ghana     -.00001
/

B0_supply_price_p(r)
/ 01_Mali     .180
  02_BFASO    .240
  03_Benin    .160
  04_Togo     .160
  05_CIvoire  .100
  06_Ghana    .100
/

B1_supply_price_p(r)
/  01_Mali     .0001
   02_BFaso    .0001
   03_Benin    .0001
   04_Togo     .0001
   05_CIvoire  .0001
   06_Ghana    .00001
/

Display B0_demand_price_p, B1_demand_price_p;

*----------------------------------------------------------------------------------------------------------------------*
Table   Treaty_flow_Agree_p(river,k,p)     potential Volta delivery flow with treaty in place
*----------------------------------------------------------------------------------------------------------------------*
                 Wet.1_sto_dev_wo_treaty    Dry.1_sto_dev_wo_treaty    Wet.2_sto_dev_wi_treaty   Dry.2_sto_dev_wi_treaty
03_Dapola_v_f                                                                 1728                     639
06_Bagre_v_f                                                                   705                     435
04_Noumb_v_f                                                                  1868                     726
09_Mango_v_f                                                                  2337                    1912
11_Nangodi_v_f                                                                 474                      10
;
*----------------------------------------------------------------------------------------------------------------------*

Display Treaty_flow_Agree_p;

*Section 3. Variables
**************** Section 3 **************************************************************
*  These endogenous (unknown) variables are defined                                     *
*  Their numerical values are not known til GAMS finds optimal soln                     *
*****************************************************************************************

*** start our multiple set looping here
set pp(p);    // potential treaty on water use policy
set mm(m);    // reservoir policy with new PMD and SMD dam
set ss(s);    // water supply scenario - historical and climate-stressed flow

pp(p)   = no;   // switches subsests off for now
mm(m)   = no;   // ditto
ss(s)   = no;   // ditto

*** end first stage of multiple set looping here*****************************************


POSITIVE VARIABLE
*Water block
Z_v                  (res,      t,k,  s,m,p)   Storage volume (million cubic mmeters)
Za_v                 (res,      t,k,  s,m,p)   Storage area   (million square meters)


*Hydropower production block
Power_prod_v         (res,hydro,t,k,  s,m,p)   Hydroelectricity production(GWh       per year)
HPower_prod_r_v      (          t,k,r,s,m,p)   Hydroelectricity production by country

hydro_price_v        (          t,k,r,s,m,p)   Hydroelectricity price       ($ per KWh=million $ per Gwh)
reservoirs_h_v       (res,      t,k,  s,m,p)   Reservoirs height (in meters)

price_demand_v       (          t,k,r,s,m,p)   Hydroelectricity demand price (
price_supply_v       (          t,k,r,s,m,p)   Hydroelectricity supply price

quantity_supply_v    (          t,k,r,s,m,p)   Quantity of electricity supplied
quantity_demand_v    (          t,k,r,s,m,p)   Quantity of electricity demanded

tot_demand_v         (          t,k,  s,m,p)   Total  quantity of electricity demanded
tot_supply_v         (          t,k,  s,m,p)   Total  quantity of electricity supplied


*Irrigated Ag water use block
Xw_v                 (aguse,j,  t,k,r,s,m,p)   Irrigation water use by crop and country (Million m3 per season)
WaterUse_r_j_v       (j,        t,k,r,s,m,p)   Total irrigation water use by crop and country (Million m3 per season)
WatAguse_r_v         (          t,k,r,s,m,p)   Total irrigation water use by country (Million m3 per season)
Wat_grains_r_v       (          t,k,r,s,m,p)   Total irrigation water use for grain prodn by country(Million m3 per season)
Wat_veges_r_v        (          t,k,r,s,m,p)   Total irrigation water use for veges prodn by country(Million m3 per season)

*Urban water use block
UrWateruse_v         (uruse,    t,k,  s,m,p)   Urban water use by nodes  (Million m3 per season)
Ch_urban_use_v       (uruse,    t,k,  s,m,p)   Change in urban use by period(Million m3 per season)
Urwatuse_r_v         (          t,k,r,s,m,p)   Total urban water use by country(Million m3 per season)

Use_per_unit_v       (uruse,    t,k,  s,m,p)   Water use per each urban household in each season(Million m3 per season)

*Total wateruse
water_use_r_v        (          t,k,r,s,m,p)   Total water use (Irrig Ag and Urban) by country  (Million m3 per season)
Total_WaterUse_r_v   (              r,s,m,p)   Total water use by country summed overtime (Million m3 per season)
Use_measured_v       (          t,k,  s,m,p)   Total water use by all countires (Million m3 per season)
Unmeasured_v         (          t,k,  s,m,p)   Total unmeasred water losses (Million m3 per season)


*Land block
hectares_j_v         (aguse, j, t,k,  s,m,p)   Land use flow -hectares of land in prodn for each crops(1000 ha per season)
land_grains_r_v      (          t,k,r,s,m,p)   Total hectares of land in grain prodn by country(1000 ha per season)
land_veges_r_v       (          t,k,r,s,m,p)   Total hectares of land in veges prodn by country(1000 ha per season)
;

FREE VARIABLES
X_v                  (i,        t,k,  s,m,p)  Water flows -- diversion-use-return - etc. (Million m3 per season)

Ave_flow_v           (river,      k,  s,m,p)  Average Water flows at gauging stations

Ch_res_v             (res,      t,k,  s,m,p)  Change in reservoir levels (+ means reservoir rises)(Million m3 per season)

* Ag benefits
Ag_Ben_j_v           (aguse,j,  t,k,  s,m,p)  Irrigated farm income by crop (US$ Million per season)
Ag_Ben___v           (aguse,    t,k,  s,m,p)  Irrigated farm income by irrigated area (US$ Million per season)
Ag_Ben_r_v           (          t,k,r,s,m,p)  Irrigated farm income by country        (US$ Million per season)
Ag_Ben_r_d_v         (          t,k,r,s,m,p)  Discounted irrigated farm income (US$ Million per season)


*Urban block
Ur_Ben_u_v           (uruse,    t,k,  s,m,p)  Urban water use benefits over all household uses (US$ Million per season)
Ur_Cost_u_v          (uruse,    t,k,  s,m,p)  Cost of urban water use over all household uses  (US$ Million per season)
Ur_NB_u_v            (uruse,    t,k,  s,m,p)  Net water use benefits over all household uses   (US$ Million per season)
Ur_NB_r_v            (          t,k,r,s,m,p)  Net water use benefits by country                (US$ Million per season)
Ur_NB_r_d_v          (          t,k,r,s,m,p)  Discounted net water use benefits by country     (US$ Million per season)


*Energy benefits
G_rev_hydro_v        (         t,k,r,s,m,p)   Gross hydroelectricity sales revenue (US$ Million per season)
cons_surp_v          (         t,k,r,s,m,p)   Hydroelectricity consumer surplus    (US$ Million per season)
prod_surp_v          (         t,k,r,s,m,p)   Hydroelectricity producer surplus    (US$ Million per season)

welfare_v            (         t,k,r,s,m,p)   Discounted hydroelectricity benefits (US$ Million per season)

total_welf_wo_trade_v(         t,k,  s,m  )
total_welf_wi_trade_v(         t,k,  s,m  )

export_v             (         t,k,r,s,m,p)   Hydroelectricity exports (GWh per season)
import_v             (         t,k,r,s,m,p)   Hydroelectricity imports (GWh per season)


*Recreation Benefits
RecBen_s_v          (res,      t,k,  s,m,p)   Recreation benefits from resrvoir stocks (US$ Million per season)
RecBen_r_v          (          t,k,r,s,m,p)   Recreation benefits by country           (US$ Million per season)
RecBen_r_d_v        (          t,k,r,s,m,p)   Discounted recreation benefit by country (US$ Million per season)



*Flood damage
Flood_v             (river,    t,k,  s,m,p)   Flood stage at the Pwalugu gauge (Meters per season)
FDamage_v           (river,    t,k,  s,m,p)   Flood damages at the Pwalugu gauge         (US$ Million per season)
FDamage_r_v         (          t,k,r,s,m,p)   Flood damages to Ghana  below Pwalugu gauge(US$ Million per season)


*Totals
TotalAg_Ben_v       (r,              s,m,p)   Discounted total national farm income over uses and time (US$ Million per season)
TotalUr_Ben_v       (r,              s,m,p)   Discounted total national urban benefits over uses and time(US$ Million per season)
TotalEner_Ben_v     (r,              s,m,p)   Discounted total national hydropower benefits over uses and time(US$ Million per season)
TotalRec_Ben_v      (r,              s,m,p)   Discounted total recreation benefits over uses and time(US$ Million per season)
TotalFDamages_v     (r,              s,m,p)   Total Flood damages to Ghana at Pwalugu gauge in Ghana (US$ Million per season)
Tot_Ben_r_v         (r,              s,m,p)   Discounted total benefits by country scenario and policy (US$ Million per season)

Tot_Ben_v           (r,                m,p)   Discounted total benefits over climate scenario by country and policy(US$ Million per season)

dnpv_looped_v                                 Discounted NPV looped over sets

;

*Section 4. Equations
**************** Section 4 **************************************************************
*  The following equations state relationships among a basin's                          *
*  hydrology, institutions, and economics                                               *
*****************************************************************************************

EQUATIONS
*****************************************************************************************
* Equations named
*****************************************************************************************
*Land Block
Land_use_r_e            (aguse,  t,k,r,s,m,p)     Hectares available by country and crop
Agland_e                (aguse,j,t,k,  s,m,p)     Irrigation crop production_no rainfed
Land_grains_r_e         (        t,k,r,s,m,p)     Total hectares in grain crops
Land_veges_r_e          (        t,k,r,s,m,p)     Total hectares in vegetable crops

*Water use Block
Xw_e                    (aguse,j,t,k,r,s,m,p)     Irrigation water use
WaterUse_r_j_e          (      j,t,k,r,s,m,p)     Irrigation water use by crop country
WatAguse_r_e            (        t,k,r,s,m,p)     Irrigation water use by country
Wat_grains_r_e          (        t,k,r,s,m,p)     Water use for grain crops
Wat_veges_r_e           (        t,k,r,s,m,p)     Water use for vegetable crops

UrWateruse_e            (uruse,  t,k,  s,m,p)     Urban water use by node
Ch_urban_use_e          (uruse,  t,k,  s,m,p)     Change in urban water use by period
Urwatuse_r_e            (        t,k,r,s,m,p)     Urban water use by country

*Water use checks
Use_measured_e          (        t,k,  s,m,p)     Total Measured use: basin's depletions summed
Unmeasured_e            (        t,k,  s,m,p)     Total Unmeasured use: basin's depletions not measured summed
Use_per_unit_e          (uruse,  t,k,  s,m,p)     Urban water use per household
Water_use_r_e           (        t,k,r,s,m,p)     Water Use by country (ag & urban)
Ch_res_e                (res,    t,k,  s,m,p)     Change in reservoir levels(+ means reservoir rises)


* Hydrology Block
Inflows_e               (inflow,   t,k,s,m,p)     Flows: set source nodes
Rivers_e                (river,    t,k,s,m,p)     Flows: hydrologic mass balance for each flow node: sources = uses
Divs_e                  (divert,   t,k,s,m,p)     Flows: wet river
Diverts_e               (divert,   t,k,s,m,p)     Flows: set divert nodes
Uses_e                  (use,      t,k,s,m,p)     Flows: define use = diversions - return flows
Returns_e               (return,   t,k,s,m,p)     Flows: set return flows
Umloss_e                (umloss,   t,k,s,m,p)     Flows: set unmeasured loss

Ave_flow_e              (river,      k,s,m,p)     Flows: average flows at gauging station

reservoirs0             (res,      t,k,s,m,p)     Initial reservoir stock
reservoirs_e            (res,      t,k,s,m,p)     Stock: reservoir mass balance accounting

Ur_Uses_e               (uruse,    t,k,s,m,p)     Urban use (depletions)
Ur_Returns_e            (urreturn, t,k,s,m,p)     Urban return flows to river

*Hydroelectricity supply block
HPower_prod_e           (res,hydro,t,k,  s,m,p)   Hydroelectricity production by reservior stock nodes
HPower_prod_r_e         (          t,k,r,s,m,p)   Hydroelectricity production by country

*************************************************************************************************************************
price_demand_e          (          t,k,r,s,m,p)   Hydroelectricity demand price function
price_supply_e          (          t,k,r,s,m,p)   Hydroelectricity supply price function

equil_wo_trade_e        (          t,k,r,s,m  )   Hydroelecticity equilibrium  conditions without trade

Equil_wi_trade_e        (          t,k,  s,m  )   Hydroelectricity market equilibrium condition with trade
equil_wi_trade1_e       (          t,k,  s,m  )   Hydroelectricity market equilibrium condition with trade Gh vs BFaso
equil_wi_trade2_e       (          t,k,  s,m  )   Hydroelectricity market equilibrium condition with trade Gh vs Mali
equil_wi_trade3_e       (          t,k,  s,m  )   Hydroelectricity market equilibrium condition with trade Gh vs Benin
equil_wi_trade4_e       (          t,k,  s,m  )   Hydroelectricity market equilibrium condition with trade Gh vs Togo
equil_wi_trade5_e       (          t,k,  s,m  )   Hydroelectricity market equilibrium condition with trade Gh vs cote dIvoire

tot_demand_e            (          t,k,  s,m,p)   Total hydroelectricity quantity demanded
tot_supply_e            (          t,k,  s,m,p)   Total hydroelectricity quantity supplied

equil_wi_trade6_e       (          t,k,  s,m  )   Total hydroelectricity martket equilibrium condition

cons_surp_e             (          t,k,r,s,m,p)   Hydroelectricity trade consumer surplus
prod_surp_e             (          t,k,r,s,m,p)   Hydroelectricity trade producer surplus


export_e                (          t,k,r,s,m,p)   Hydroelectricity exports = imports


*****************************************************************************************************************************
*Reservior block
Za_e                   (res,      t,k,  s,m,p)   Stock: reservoir area
Evap_e                 (evap,     t,k,  s,m,p)   Reservior Evaporation
Precip_e               (precip,   t,k,  s,m,p)   Rainfall in reserviors
reservoirs_h_e         (res,      t,k,  s,m,p)   Reservior Height

* Economics Block *
*Irrigation Benefits
Ag_Ben_j_e             (aguse,  j,t,k,  s,m,p)   Farm income by crop
Ag_Ben___e             (aguse,    t,k,  s,m,p)   Farm income by irrigation area
Ag_Ben_r_e             (          t,k,r,s,m,p)   Farm income by country
Ag_Ben_r_d_e           (          t,k,r,s,m,p)   Farm income by country discounted


*Urban Water supply Benefits
Ur_Ben_u_e             (uruse,    t,k,  s,m,p)   Urban water use  benefits by nodes
Ur_Cost_u_e            (uruse,    t,k,  s,m,p)   Urban cost of water use by use nodes
Ur_NB_u_e              (uruse,    t,k,  s,m,p)   Urban net benefits from water use by use ndes
Ur_NB_r_e              (          t,k,r,s,m,p)   Urban net benefits by country
Ur_NB_r_d_e            (          t,k,r,s,m,p)   Urban net benefits by country discounted


*Recreation Benefits
RecBen_s_e             (res,      t,k,  s,m,p)   Receation benefits by reservior stock nodes
RecBen_r_e             (          t,k,r,s,m,p)   Receation benefits by reservior stock nodes by country
RecBen_r_d_e           (          t,k,r,s,m,p)   Discounted receation benefits by reservior stock nodes by country


*Hydroelectricity Benefits
G_rev_hydro_e          (          t,k,r,s,m,p)   Hydroelectricity revenue

welfare_e              (          t,k,r,s,m,p)   Discounted total hydroelectricity benefits

total_welf_wo_e        (          t,k,  s,m  )   Discounted total hydroelectricity benefits without trade
total_welf_wi_e        (          t,k,  s,m  )   Discounted total hydroelectricity benefits with trade


*Flood Damages Avoided
Flood_e                  (        t,k,  s,m,p)   Flood stage at the Pwalugu gauge
FDamage_e                (        t,k,  s,m,p)   Flood damages at the Pwalugu gauge
FDamage_r_e              (        t,k,r,s,m,p)   Flood damages to Ghana  below Pwalugu gauge


*Totals
TotalAg_Ben_e            (r,            s,m,p)   Total discounted benfits from Irrigated agriculture water use summed
TotalUr_Ben_e            (r,            s,m,p)   Total discounted benfits from Urban water use summed
TotalRec_Ben_e           (r,            s,m,p)   Total discounted benfits from Recreation summed
TotalEner_Ben_e          (r,            s,m,p)   Total discounted benfits from Hydro power summed
TotalFDamages_e          (r,            s,m,p)   Total flood damages at the Pwalugu gauge summed

pareto_constraint_e      (r,              m  )   Pareto Improvement Constraint

Tot_Ben_r_e              (r,            s,m,p)   Total dicounted benefits for each country
Tot_Ben_e                (r,              m,p)   Total discounted benfits from IrriAg+UrUse+Rec+Hydro summed
dnpv_looped_e                                    Total discounted benefits looped
;


*in these equations you need to change p and s to pp and ss for looping purposes

***********************************************************************************************************************************************
* Equations defined algebraiclly using equation names
***********************************************************************************************************************************************
* Land Block (units - 1000 hectares/season)
***********************************************************************************************************************************************
Land_use_r_e(aguse,t,k,r,ss,mm,pp)$ks(k) ..sum ((j),hectares_j_v(aguse,j,t,k,ss,mm,pp))*user_p(aguse,r) =l= RHS_p(aguse,t,r,mm);// Total land in production

Agland_e    (aguse,j,t,k,ss,mm,pp)$ks(k) ..         hectares_j_v(aguse,j,t,k,ss,mm,pp)$ks(k)            =e=  hectares_j_v(aguse,j,t,'dry',ss,mm,pp);

Land_grains_r_e( t,k,r,ss,mm,pp)$ks(k)   ..  land_grains_r_v( t,k,r,ss,mm,pp)   =e= sum((aguse,jg), hectares_j_v(aguse,jg,t,k,ss,mm,pp) * user_p(aguse,r)) + eps;  // grain crops summed over nodes by country
Land_veges_r_e ( t,k,r,ss,mm,pp)$ks(k)   ..  land_veges_r_v ( t,k,r,ss,mm,pp)   =e= sum((aguse,jv), hectares_j_v(aguse,jv,t,k,ss,mm,pp) * user_p(aguse,r)) + eps;


************************************************************************************************************************************************
* Hydrology  Block (in water units- million m3 /season)
************************************************************************************************************************************************
Inflows_e(inflow,t,k,ss,mm,pp).. X_v(inflow,t,k,ss,mm,pp) =e=   source_p(inflow,t,k,ss,mm,pp);//Note:source(inflow,t)= headflows(inflow,t)

Rivers_e (river, t,k,ss,mm,pp).. X_v(river, t,k,ss,mm,pp) =e=   sum(inflow,    Bv_p(inflow, river)  * X_v(inflow, t,k,ss,mm,pp)) +
                                                                sum(riverp,    Bv_p(riverp, river)  * X_v(riverp, t,k,ss,mm,pp)) +
                                                                sum(divert,    Bv_p(divert, river)  * X_v(divert, t,k,ss,mm,pp)) +
                                                                sum(return,    Bv_p(return, river)  * X_v(return, t,k,ss,mm,pp)) +
                                                                sum(umloss,    Bv_p(umloss, river)  * X_v(umloss, t,k,ss,mm,pp)) +
                                                                sum(rel,       Bv_p(rel,    river)  * X_v(rel,    t,k,ss,mm,pp)) ;     // GAMS EQUIVALENT OF A MATRIX EQUATION

Divs_e   (divert,t,k,ss,mm,pp).. X_v(divert,t,k,ss,mm,pp) =l=   sum(inflow,    Bd_p(inflow, divert) * X_v(inflow, t,k,ss,mm,pp)) +
                                                                sum(river,     Bd_p(river,  divert) * X_v(river,  t,k,ss,mm,pp)) +
                                                                sum(divertp,   Bd_p(divertp,divert) * X_v(divertp,t,k,ss,mm,pp)) +
                                                                sum(return,    Bd_p(return, divert) * X_v(return, t,k,ss,mm,pp)) +
                                                                sum(umloss,    Bd_p(umloss, divert) * X_v(umloss, t,k,ss,mm,pp)) +
                                                                sum(rel,       Bd_p(rel,    divert) * X_v(rel,    t,k,ss,mm,pp)) ;


Ave_flow_e(river,k,ss,mm,pp).. Ave_flow_v(river,k,ss,mm,pp)=e=  sum(t, X_v(river,t,k,ss,mm,pp)) / card(t);


****************** ag water use based on crop water use (ET) ****************************************************************************************************************
Diverts_e (agdivert,t,k,  ss,mm,pp).. X_v(agdivert,t,k,ss,mm,pp) =e= sum((j), Bu_p(agdivert, j,k)* sum(aguse, ID_du_p(agdivert,aguse) * hectares_j_v(aguse,j,t,k,ss,mm,pp)));
Uses_e    (aguse,   t,k,  ss,mm,pp).. X_v(aguse,   t,k,ss,mm,pp) =e= sum((j), Bu_p(aguse,    j,k)*    (                            1) * hectares_j_v(aguse,j,t,k,ss,mm,pp));
Returns_e (agreturn,t,k,  ss,mm,pp).. X_v(agreturn,t,k,ss,mm,pp) =e= sum((j), Bu_p(agreturn, j,k)* sum(aguse, ID_ru_p(agreturn,aguse) * hectares_j_v(aguse,j,t,k,ss,mm,pp)));
Umloss_e  (umloss,  t,k,  ss,mm,pp).. X_v(umloss,  t,k,ss,mm,pp) =e= sum((j), Bu_p(umloss,   j,k)* sum(aguse, ID_lu_p(umloss,  aguse) * hectares_j_v(aguse,j,t,k,ss,mm,pp)));


*******************Water use*************************************************************************************************************************************************
WaterUse_r_j_e (j,  t,k,r,ss,mm,pp).. WaterUse_r_j_v (j,t,k,r,ss,mm,pp)=e= sum((aguse),Bu_p(aguse,j,k)*(hectares_j_v(aguse,j,t,k,ss,mm,pp) * user_p(aguse,r))) + eps;
Xw_e       (aguse,j,t,k,r,ss,mm,pp).. Xw_v     (aguse,j,t,k,r,ss,mm,pp)=e= Bu_p(aguse,j,k)*hectares_j_v(aguse,j,t,k,ss,mm,pp) * user_p(aguse,r)+ eps;

WatAguse_r_e     (  t,k,r,ss,mm,pp).. WatAguse_r_v   (  t,k,r,ss,mm,pp)=e= sum( aguse, X_v(aguse,t,k,ss,mm,pp)  * user_p(aguse, r))     + eps;
Wat_grains_r_e   (  t,k,r,ss,mm,pp).. Wat_grains_r_v (  t,k,r,ss,mm,pp)=e= sum((aguse,jg), Bu_p(aguse,jg,k) * (hectares_j_v(aguse,jg,t,k,ss,mm,pp) * user_p(aguse,r))) + eps;
Wat_veges_r_e    (  t,k,r,ss,mm,pp).. Wat_veges_r_v  (  t,k,r,ss,mm,pp)=e= sum((aguse,jv), Bu_p(aguse,jv,k) * (hectares_j_v(aguse,jv,t,k,ss,mm,pp) * user_p(aguse,r))) + eps;
*****************************************************************************************************************************************************************************
* ag diversions need to reduce river gauged flow at all downstream gauges.

* Urban hydrology: assumes a single treatment technology for cities urban use
Ur_Uses_e    (uruse,   t,k,ss,mm,pp).. X_v(uruse,   t,k,ss,mm,pp)         =e= sum(urdivert,   Bmu_p(urdivert, uruse   ) * X_v(urdivert, t,k,ss,mm,pp)) ;
Ur_Returns_e (urreturn,t,k,ss,mm,pp).. X_v(urreturn,t,k,ss,mm,pp)         =e= sum(urdivert,   Bmr_p(urdivert, urreturn) * X_v(urdivert, t,k,ss,mm,pp)) ;
Ch_urban_use_e(uruse,t,k,ss,mm,pp)  .. Ch_urban_use_v(uruse,t,k,ss,mm,pp) =e= X_v(uruse,t,k,ss,mm,pp) - X_v(uruse,t-1,k,ss,mm,pp);  // defines change in urban use by period
Use_per_unit_e(uruse,t,k,ss,mm,pp)  .. Use_per_unit_v(uruse,t,k,ss,mm,pp) =e= X_v(uruse,t,k,ss,mm,pp)/scale_p(uruse,t,k,ss,mm,pp); // water use per average household

UrWateruse_e (uruse, t,k,  ss,mm,pp).. UrWateruse_v(uruse,t,k,  ss,mm,pp) =e= X_v(uruse,t,k,ss,mm,pp)+ eps;
Urwatuse_r_e (       t,k,r,ss,mm,pp).. Urwatuse_r_v  (    t,k,r,ss,mm,pp) =e= sum((uruse), X_v(uruse,t,k,ss,mm,pp)* user_p(uruse, r)) + eps;

* Total Water Use
Water_use_r_e  (    t,k,r,ss,mm,pp).. Water_use_r_v (    t,k,r,ss,mm,pp)=e= sum(use,   X_v(use,     t,k,ss,mm,pp)* user_p(use, r))   + eps; //Total Water Use


* Hydrology check
Use_measured_e(t,k,ss,mm,pp)        .. Use_measured_v(t,k,ss,mm,pp)      =e=  sum(use,    X_v(use,t,k,ss,mm,pp));
Unmeasured_e(t,k,ss,mm,pp)          .. Unmeasured_v  (t,k,ss,mm,pp)      =e=  sum(umloss, X_v(umloss,t,k,ss,mm,pp));
Ch_res_e(res,t,k,ss,mm,pp)          .. Ch_res_v(res,t,k,ss,mm,pp)        =e= -sum(rel,   BLv_p(rel,res) * X_v(rel,t,k,ss,mm,pp));//change in reservoir levels (+ means reservoir rises)


**************************************************************************************************************************************************************************************
* Reservoir storage Block  (in water units - million m3/season)
**************************************************************************************************************************************************************************************
reservoirs0(res,t,k,ss,mm,pp) $ [(ord(k) eq 1) and (ord(t) eq 1) ]..  Z_v(res,t,k,ss,mm,pp)    =e= Z0_p(res);//Initial storage

reservoirs_e(res,t,k,ss,mm,pp)..  Z_v(res,t,k,ss,mm,pp)  $ [(ord(k) * ord(t)) gt 1]   =e=
                                                                sum[(t2,k2  ) $ linktime(t,k,t2,k2), Z_v(res,  t2,k2,ss,mm,pp)]
                                                              - sum[rel, BLv_p(rel,   res)   *  X_v(rel,  t,k,ss,mm,pp)]
                                                              - sum[evap,Ber_p(evap,  res)   *  X_v(evap, t,k,ss,mm,pp)]
                                                              + sum[precip,Bra_p(precip,res) *  X_v(precip, t,k,ss,mm,pp)]; //Later storage from year 2 onwards

Za_e  (res, t,k,ss,mm,pp)             .. Za_v(res,t,k,ss,mm,pp)   =e= B0ar_p(res)  +  B1ar_p(      res)         * Z_v (res,t,k,ss,mm,pp);
Evap_e(evap,t,k,ss,mm,pp)             .. X_v(evap,t,k,ss,mm,pp)   =e= sum(res,Be_p(evap, res)*evapdist_p(res,k) * Za_v(res,t,k,ss,mm,pp));
Precip_e(precip,t,k,ss,mm,pp)         .. X_v(precip,t,k,ss,mm,pp) =e= sum(res,Bp_p(precip,res)*Prepdist_p(res,k)* Za_v(res,t,k,ss,mm,pp));

reservoirs_h_e(res,t,k,ss,mm,pp)$(bhh(res) eq 1)    ..   reservoirs_h_v(res,t,k,ss,mm,pp)   =e={intercept_p(res,mm)*[.001 +  Z_v(res,t,k,ss,mm,pp)]**exp_p(res,mm)};//  2*[Z_v(res,t,s)/intercept_p(res)];
*********************************************************************************************************************************************************************************

*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
* Economics Block (in monetary units - US $)
*********************************************************************************************************************************************************************************
*Agriculture - Irrigation Economic Benefits (basicaaly irrigation farm income) depend on agricultural depletions of water
*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Ag_Ben_j_e  (aguse,j,t,k, ss,mm,pp).. Ag_Ben_j_v  (aguse,j,t,k,ss,mm,pp)  =e= Net_rev_p(aguse,j)* hectares_j_v(aguse,j,t,k,ss,mm,pp);
Ag_Ben___e  (aguse, t,k,  ss,mm,pp).. Ag_Ben___v  (aguse,t,k,  ss,mm,pp)  =e= sum((j), Ag_Ben_j_v  (aguse,j,t,k,ss,mm,pp));// by aguse node and time summed over crop
Ag_Ben_r_e  (       t,k,r,ss,mm,pp).. Ag_Ben_r_v  (      t,k,r,ss,mm,pp)  =e= sum((aguse), Ag_Ben___v  (aguse,t,k,  ss,mm,pp) * user_p(aguse,r)); //total ag benefits over crop and aguse node
Ag_Ben_r_d_e(       t,k,r,ss,mm,pp).. Ag_Ben_r_d_v(      t,k,r,ss,mm,pp)  =e= df_p(t)* Ag_Ben_r_v      (      t,k,r,ss,mm,pp);


*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
*Urban - Domestic Water Supply) Benefits depend on urban water depletions for household use-drinking and other uses
*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Ur_Ben_u_e  (uruse,  t,k,ss,mm,pp)    ..  Ur_Ben_u_v(uruse,  t,k,ss,mm,pp)        =e=
                                                  scale_p(uruse,t,k,ss,mm,pp)  * Ben_u_p(uruse, 'intercept')                              +
                                                                            Ben_u_p(uruse, 'linear'   ) * X_v(uruse,t,k,ss,mm,pp)         +
                                       (1/scale_p(uruse,t,k,ss,mm,pp)) * Ben_u_p(uruse, 'quadratic') * X_v(uruse,t,k,ss,mm,pp)*X_v(uruse,t,k,ss,mm,pp);//benefits over all urban households

Ur_Cost_u_e(uruse, t,k,ss,mm,pp)      ..  Ur_Cost_u_v(uruse, t,k,ss,mm,pp)        =e=   [(Ur_price_p(uruse) * X_v(uruse,t,k,ss,mm,pp))];//mc=tvc for all unit -single treatment plant
Ur_NB_u_e  (uruse, t,k,ss,mm,pp)      ..  Ur_NB_u_v(uruse,   t,k,ss,mm,pp)        =e=   Ur_Ben_u_v(uruse,t,k,ss,mm,pp) - Ur_Cost_u_v(uruse,t,k,ss,mm,pp);
Ur_NB_r_e (      t,k,r,ss,mm,pp)      ..  Ur_NB_r_v (      t,k,r,ss,mm,pp)        =e= sum ((uruse), Ur_NB_u_v(uruse,   t,k,ss,mm,pp)* user_p(uruse,r));
Ur_NB_r_d_e(     t,k,r,ss,mm,pp)      ..  Ur_NB_r_d_v(     t,k,r,ss,mm,pp)        =e= df_p(t)*Ur_NB_r_v (      t,k,r,ss,mm,pp);//dicounted net benefits


*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
*Recreation (Environmental)  Economic Bnefits  depend on the storage volume (stock) of each reservoir -fishing, boating,etc  seadist_r(res,k)
*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RecBen_s_e   (res, t,k,  ss,mm,pp)$ (brr(res))  .. RecBen_s_v  (res, t,k,  ss,mm,pp) =e= MBe_p(res)*(eps + Z_v(res,t,k,ss,mm,pp)) ** elas_rec_p(res);  // nonlinear recreation economic benefits not discounted
RecBen_r_e   (     t,k,r,ss,mm,pp)              .. RecBen_r_v  (     t,k,r,ss,mm,pp) =e= sum ((res), brr(res)*1.00*RecBen_s_v (res, t,k,  ss,mm,pp)*stock_p(res, r));
RecBen_r_d_e (     t,k,r,ss,mm,pp)              .. RecBen_r_d_v(     t,k,r,ss,mm,pp) =e= df_p(t)* RecBen_r_v  (     t,k,r,ss,mm,pp);  // discounted recreation benefits

*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
*Hydroelectricity power  Economic Benefits  depend on the storage volume (stock) of each reservoir and hydro turbine releases
*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
*                                                                  Million (m3/year) =0.0316887646 m3/s    * Hydro releases/year seadist_h(res,k)  *(discharge-Mm3/year)                  *power production dummy
*                                                                            power (W per year)=(converts from Wh to GWh )*(head in meters) *(converts discharge from Mm3/y to m3/s)*(density of water-kg/m3-997 kg/m³)*gravitational constatnt*efficiency*from GW to GWh per season
HPower_prod_e  (res,hydro,t,k,  ss,mm,pp) $(bh(res,hydro)).. Power_prod_v(res,hydro,t,k,ss,mm,pp)=e= (0.000000001)*reservoirs_h_v(res, t,k,ss,mm,pp)*(0.0316887646* X_v(hydro,t,k,ss,mm,pp))   *997  *power_p(res,mm)            *9.807              *teff_p(res,mm)*8760;
*If we want to know the electricity generation then we multiple KW by the number of specific period of time (hours, month) to get generation.

HPower_prod_r_e(          t,k,r,ss,mm,pp)                 .. quantity_supply_v(t,k,r,ss,mm,pp)    =e= sum ((res, hydro), bh(res,hydro)*1.00*Power_prod_v(res,hydro,t,k,  ss,mm,pp)*turb_p(res, hydro, r));

price_demand_e (          t,k,r,ss,mm,pp)                 .. price_demand_v(   t,k,r,ss,mm,pp) =e=  B0_demand_price_p(r) + B1_demand_price_p(r) * quantity_demand_v(t,k,r,ss,mm,pp);

price_supply_e (          t,k,r,ss,mm,pp)                 .. price_supply_v(   t,k,r,ss,mm,pp) =e=  B0_supply_price_p(r) + B1_supply_price_p(r) * quantity_supply_v(t,k,r,ss,mm,pp); ///////

cons_surp_e    (          t,k,r,ss,mm,pp)                 .. cons_surp_v   (   t,k,r,ss,mm,pp) =e=  0.5 * [B0_demand_price_p(r)- price_demand_v(t,k,r,ss,mm,pp)] * quantity_demand_v(t,k,r,ss,mm,pp);
prod_surp_e    (          t,k,r,ss,mm,pp)                 .. prod_surp_v   (   t,k,r,ss,mm,pp) =e=  0.5 * [price_supply_v(t,k,r,ss,mm,pp)- B0_supply_price_p(r)] * quantity_supply_v(t,k,r,ss,mm,pp);

G_rev_hydro_e  (          t,k,r,ss,mm,pp)                 .. G_rev_hydro_v (   t,k,r,ss,mm,pp) =e=  price_demand_v(t,k,r,ss,mm,pp) * quantity_supply_v(t,k,r,ss,mm,pp);


equil_wo_trade_e (        t,k,r,ss,mm   )                 .. quantity_demand_v(t,k,r,ss,mm,'1_sto_dev_wo_treaty') =e=  quantity_supply_v(t,k,r,ss,mm,'1_sto_dev_wo_treaty');


equil_wi_trade_e(         t,k,  ss,mm   )                 .. sum((r), quantity_demand_v(t,k,r,ss,mm,'2_sto_dev_wi_treaty')) =e= sum((r), quantity_supply_v(t,k,r,ss,mm,'2_sto_dev_wi_treaty'));

equil_wi_trade1_e(        t,k,  ss,mm   )                 .. price_demand_v   (t,k,'06_ghana',ss,mm,'2_sto_dev_wi_treaty')  =e= price_demand_v(t,k,'02_BFASO',ss,mm,'2_sto_dev_wi_treaty');
equil_wi_trade2_e(        t,k,  ss,mm   )                 .. price_demand_v   (t,k,'06_ghana',ss,mm,'2_sto_dev_wi_treaty')  =e= price_demand_v(t,k,'01_Mali', ss,mm,'2_sto_dev_wi_treaty');
equil_wi_trade3_e(        t,k,  ss,mm   )                 .. price_demand_v   (t,k,'06_ghana',ss,mm,'2_sto_dev_wi_treaty')  =e= price_demand_v(t,k,'03_Benin', ss,mm,'2_sto_dev_wi_treaty');
equil_wi_trade4_e(        t,k,  ss,mm   )                 .. price_demand_v   (t,k,'06_ghana',ss,mm,'2_sto_dev_wi_treaty')  =e= price_demand_v(t,k,'04_Togo', ss,mm,'2_sto_dev_wi_treaty');
equil_wi_trade5_e(        t,k,  ss,mm   )                 .. price_demand_v   (t,k,'06_ghana',ss,mm,'2_sto_dev_wi_treaty')  =e= price_demand_v(t,k,'05_CIvoire', ss,mm,'2_sto_dev_wi_treaty');

tot_demand_e     (        t,k,  ss,mm,pp)                 .. tot_demand_v(t,k,ss,mm,pp)  =e=  sum((r), quantity_demand_v(t,k,r,ss,mm,pp));
tot_supply_e     (        t,k,  ss,mm,pp)                 .. tot_supply_v(t,k,ss,mm,pp)  =e=  sum((r), quantity_supply_v(t,k,r,ss,mm,pp));

equil_wi_trade6_e(        t,k,  ss,mm   )                 .. tot_demand_v(t,k,ss,mm,'2_sto_dev_wi_treaty') =e= tot_supply_v(t,k,ss,mm,'2_sto_dev_wi_treaty');


Welfare_e      (          t,k,r,ss,mm,pp)                 .. Welfare_v     (         t,k,r,ss,mm,pp) =e=  df_p(t)*[G_rev_hydro_v (t,k,r,ss,mm,pp)+cons_surp_v(t,k,r,ss,mm,pp) + prod_surp_v(t,k,r,ss,mm,pp)];


total_welf_wo_e (         t,k,  ss,mm   )                 .. total_welf_wo_trade_v(  t,k,ss,mm   ) =e=  sum((r), welfare_v(t,k,r,ss,mm,'1_sto_dev_wo_treaty'));

total_welf_wi_e (         t,k,  ss,mm   )                 .. total_welf_wi_trade_v(  t,k,ss,mm   ) =e=  sum((r), welfare_v(t,k,r,ss,mm,'2_sto_dev_wi_treaty'));


export_e       (          t,k,r,ss,mm,pp)                 .. export_v      (         t,k,r,ss,mm,pp) =e=  quantity_supply_v(t,k,r,ss,mm,pp)- quantity_demand_v(t,k,r,ss,mm,pp);


*----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
*Flood Control Benefits is Damage Avoided due to the reservior storage

Flood_e        (          t,k,  ss,mm,pp)  ..  Flood_v    ('12_Pwalugu_v_f',t,k,  ss,mm,pp) =e= max{0,[1.0*X_v('12_Pwalugu_v_f',t,k,ss,mm,pp)**0.5 - Constant ('12_Pwalugu_v_f')]};
FDamage_e      (          t,k,  ss,mm,pp)  ..  FDamage_v  ('12_Pwalugu_v_f',t,k,  ss,mm,pp) =e= Flood_v('12_Pwalugu_v_f',  t,k,ss,mm,pp)*value_p ('12_Pwalugu_v_f',mm);
FDamage_r_e    (          t,k,r,ss,mm,pp)  ..  FDamage_r_v(                 t,k,r,ss,mm,pp) =e= FDamage_v('12_Pwalugu_v_f',t,k,ss,mm,pp)* rivv_p ('12_Pwalugu_v_f', r);


*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
*Totals   (summation over time and seasons)
TotalAg_Ben_e  (r,ss,mm,pp)        ..  TotalAg_Ben_v  (r,ss,mm,pp) =e= sum ((t,k), Ag_Ben_r_d_v   (     t,k,r,ss,mm,pp)); // sums ag net benefits
TotalUr_Ben_e  (r,ss,mm,pp)        ..  TotalUr_Ben_v  (r,ss,mm,pp) =e= sum ((t,k), Ur_NB_r_d_v    (     t,k,r,ss,mm,pp)); // sums urban net benefits
TotalEner_Ben_e(r,ss,mm,pp)        ..  TotalEner_Ben_v(r,ss,mm,pp) =e= sum ((t,k), Welfare_v      (     t,k,r,ss,mm,pp)); // sums energy benefits
TotalRec_Ben_e (r,ss,mm,pp)        ..  TotalRec_Ben_v (r,ss,mm,pp) =e= sum ((t,k), RecBen_r_d_v   (     t,k,r,ss,mm,pp)); // sums recreation benefits
TotalFDamages_e(r,ss,mm,pp)        ..  TotalFDamages_v(r,ss,mm,pp) =e= sum ((t,k), FDamage_r_v    (     t,k,r,ss,mm,pp)); // sums flood damages


Tot_Ben_r_e    (r,ss,mm,pp)        .. Tot_Ben_r_v     (r,ss,mm,pp) =e=  TotalAg_Ben_v  (r,ss,mm,pp)
                                                                    +   TotalRec_Ben_v (r,ss,mm,pp)
                                                                    +   TotalUr_Ben_v  (r,ss,mm,pp)
                                                                    +   TotalEner_Ben_v(r,ss,mm,pp)
                                                                    -   TotalFDamages_v(r,ss,mm,pp);


Tot_Ben_e      (r,   mm,pp)        ..  Tot_Ben_v      (r,   mm,pp) =e= sum((ss), Tot_Ben_r_v(r,ss,mm,pp));


* THIS CONSTRAINT SHOWS TOTAL ECONOMIC WELFARE IS BETTER WITH THE TREATY THAN WITHOUT IT

pareto_constraint_e(r,    mm)..  Tot_Ben_v(r,mm,'1_sto_dev_wo_treaty')  =g= Tot_Ben_v(r,mm,'2_sto_dev_wi_treaty');


dnpv_looped_e                      ..  dnpv_looped_v               =e= sum((r,mm,pp), Tot_Ben_v(r,mm,pp)- dam_cost_p(r,mm));


**************************  End of equations ****************************************************************************************************************************************


*Section 5. Models
**************** Section 5 **************************************************************
*  The following section defines models.                                                *
*  Each model is defined by a set of equations used                                     *
*  for which one single variable is optimized (min or max)                              *
*****************************************************************************************

* This simple prototype model uses ALL equations defined above.  But larger models
* may exclude some equations. For example, each of several institution could be defined
* by one equation.  And each of several model might conduct a single policy experiment
* in which that model tries out a single institution.  This would require deleting all
* institutional equations except the one analyzed.
* If you need to EXclude some equations, list INcluded equations where ALL appears below

MODEL VOLTA_PROTOTYPE /ALL/;  // This model uses ALL equations


*Section 6. Solves
**************** Section 6 ****************************************************************
*  The following section defines all solves requested,                                    *
*  Each solve states a single model for which an optimum is requested.                    *
*                                                                                         *
*  Upper, lower and fixed bounds on certain variables can also be included here           *
*  Bounding variables here gives that variable a non-zero shadow price where the optimal  *
*  solution appears at that boundary.  If the bound doesn't constrain the model           *
*  the variable's shadow price is zero (complementary slackness)                          *
*******************************************************************************************
* Non-negative flows at nodes below
X_v.lo(inflow,t,k,s,m,p) = 0;
X_v.lo(river, t,k,s,m,p) = 0;
X_v.lo(divert,t,k,s,m,p) = 0;
X_v.lo(use,   t,k,s,m,p) = 0;
X_v.lo(return,t,k,s,m,p) = 0;
X_v.lo(umloss,t,k,s,m,p) = 0;

*Non-negative constraints on land
hectares_j_v.lo(aguse,j,t,k,s,m,p)         = 0;// nonnegative ag land
hectares_j_v.fx(aguse,j,t,k,s,m,p) $kn(k)  = 0;// no water withdrawal for irri ag in wet season

*Contraints on headflows
X_v.up(inflow,t,k,s,m,p) = 1.00*source_p(inflow,t,k,s,m,p);  // upper bound on inflows// inflows at top gauge cannot exceed basin inflows
X_v.lo(inflow,t,k,s,m,p) = 0.01;

*constraints on flooding in dry season
Flood_v.up('12_Pwalugu_v_f',t,'dry',s,m,p)= 0.001;

******** reservoir stock constraints and other contraints*****************************************************

* Sustainability terminal condition: each water stock (reservoir) ends with terminal volume > starting volume.
* It avoids depleting stocks in last period
*-------------------------------------------------------------------------------------------------------------------------------------------------------
Z_v.up(res,t,k,s,m,p) = capacity_p(res,m);  // respect each reservoir's maximum volume capacity-reservoir maximum physical capacity at each year

Z_v.lo('01_SAMEN_res_s', t,k,s,'Plus_PMD_SMD',p)$ [(ord(k) eq card(k)) and (ord(t) eq card(t))] = Z0_p('01_SAMEN_res_s');
Z_v.lo('03_ZIGA_res_s',  t,k,s,'Plus_PMD_SMD',p)$ [(ord(k) eq card(k)) and (ord(t) eq card(t))] = 170;
Z_v.lo('04_BAGRE_res_s', t,k,s,'Plus_PMD_SMD',p)$ [(ord(k) eq card(k)) and (ord(t) eq card(t))] = Z0_p('04_BAGRE_res_s');
Z_v.lo('05_KOMP_res_s',  t,k,s,'Plus_PMD_SMD',p)$ [(ord(k) eq card(k)) and (ord(t) eq card(t))] = Z0_p('05_KOMP_res_s');
Z_v.lo('07_PWALU_res_s', t,k,s,'Plus_PMD_SMD',p)$ [(ord(k) eq card(k)) and (ord(t) eq card(t))] = Z0_p('07_PWALU_res_s');
Z_v.lo('08_BUI_res_s',   t,k,s,'Plus_PMD_SMD',p)$ [(ord(k) eq card(k)) and (ord(t) eq card(t))] = Z0_p('08_BUI_res_s');

Z_v.lo('12_LVOLTA_res_s',t,k,'Histor_flow','Plus_PMD_SMD',p)$ [(ord(k) eq card(k)) and (ord(t) eq card(t))] = Z0_p('12_LVOLTA_res_s');
Z_v.lo('12_LVOLTA_res_s',t,k,'CliStr_flow','Plus_PMD_SMD','1_sto_dev_wo_treaty')$ [(ord(k) eq card(k)) and (ord(t) eq card(t))] = .7*Z0_p('12_LVOLTA_res_s');
Z_v.lo('12_LVOLTA_res_s',t,k,'CliStr_flow','Plus_PMD_SMD','2_sto_dev_wi_treaty')$ [(ord(k) eq card(k)) and (ord(t) eq card(t))] = .7*Z0_p('12_LVOLTA_res_s');

Z_v.lo('13_KPONG_res_s', t,k,s,'Plus_PMD_SMD',p)$ [(ord(k) eq card(k)) and (ord(t) eq card(t))] = Z0_p('13_KPONG_res_s');
*----------------------------------------------------------------------------------------------------------------------------------------------------------
*----------------------------------------------------------------------------------------------------------------
*Bounds on new hectares in production as a result of the development of the new dams
*----------------------------------------------------------------------------------------------------------------
hectares_j_v.fx('PwaluAg_u_f','rice',t,'dry','Histor_flow','Plus_PMD_SMD',p)= .6*LandRHS_p('PwaluAg_u_f');
hectares_j_v.fx('PwaluAg_u_f','legu',t,'dry','Histor_flow','Plus_PMD_SMD',p)= .2*LandRHS_p('PwaluAg_u_f');
hectares_j_v.fx('PwaluAg_u_f','vege',t,'dry','Histor_flow','Plus_PMD_SMD',p)= .2*LandRHS_p('PwaluAg_u_f');

hectares_j_v.fx('SourouAg_u_f','vege',t,'dry',s,'Plus_PMD_SMD',p)= 0;

hectares_j_v.up('PwaluAg_u_f','rice',t,'dry','CliStr_flow','Plus_PMD_SMD',p)= .4*LandRHS_p('PwaluAg_u_f');
hectares_j_v.up('PwaluAg_u_f','legu',t,'dry','CliStr_flow','Plus_PMD_SMD',p)= .2*LandRHS_p('PwaluAg_u_f');
hectares_j_v.up('PwaluAg_u_f','vege',t,'dry','CliStr_flow','Plus_PMD_SMD',p)= .2*LandRHS_p('PwaluAg_u_f');

hectares_j_v.fx('SamenAg_u_f','rice',t,'dry','Histor_flow','Plus_PMD_SMD',p)=.50*LandRHS_p('SamenAg_u_f');
hectares_j_v.fx('SamenAg_u_f','Vege',t,'dry','Histor_flow','Plus_PMD_SMD',p)=.25*LandRHS_p('SamenAg_u_f');
hectares_j_v.fx('SamenAg_u_f','legu',t,'dry','Histor_flow','Plus_PMD_SMD',p)=.25*LandRHS_p('SamenAg_u_f');

hectares_j_v.up('SamenAg_u_f','vege',t,'dry','CliStr_flow','Plus_PMD_SMD',p)=.25*LandRHS_p('SamenAg_u_f');
hectares_j_v.up('SamenAg_u_f','legu',t,'dry','CliStr_flow','Plus_PMD_SMD',p)=.25*LandRHS_p('SamenAg_u_f');
hectares_j_v.up('SamenAg_u_f','rice',t,'dry','CliStr_flow','Plus_PMD_SMD',p)=.30*LandRHS_p('SamenAg_u_f');

hectares_j_v.fx('TonoAg_u_f', 'rice',t,'dry','Histor_flow','Plus_PMD_SMD',p)=.45*LandRHS_p('TonoAg_u_f');
hectares_j_v.fx('TonoAg_u_f', 'Vege',t,'dry','Histor_flow','Plus_PMD_SMD',p)=.55*LandRHS_p('TonoAg_u_f');
hectares_j_v.up('TonoAg_u_f', 'rice',t,'dry','CliStr_flow','Plus_PMD_SMD',p)=.30*LandRHS_p('TonoAg_u_f');
hectares_j_v.up('TonoAg_u_f', 'Vege',t,'dry','CliStr_flow','Plus_PMD_SMD',p)=.30*LandRHS_p('TonoAg_u_f');

hectares_j_v.fx('BuiAg_u_f',  'Rice',t,'dry',s,'Plus_PMD_SMD',p)=.7*LandRHS_p('BuiAg_u_f');
hectares_j_v.fx('BagreAg_u_f','Vege',t,'dry',s,'Plus_PMD_SMD',p)=.3*LandRHS_p('BagreAg_u_f');

hectares_j_v.up('SorouMAg_u_f','Rice',t,'dry','CliStr_flow',m,'1_sto_dev_wo_treaty')=.68*LandRHS_p('SorouMAg_u_f');
hectares_j_v.up('SorouMAg_u_f','Rice',t,'dry','CliStr_flow',m,'2_sto_dev_wi_treaty')=.66*LandRHS_p('SorouMAg_u_f');

hectares_j_v.up('PorgaAg_u_f','Rice',t,'dry', 'CliStr_flow',m,'1_sto_dev_wo_treaty')=.75*LandRHS_p('PorgaAg_u_f');
hectares_j_v.up('PorgaAg_u_f','Rice',t,'dry', 'CliStr_flow',m,'2_sto_dev_wi_treaty')=.70*LandRHS_p('PorgaAg_u_f');

hectares_j_v.up('DapaoAg_u_f','Rice',t,'dry', 'CliStr_flow',m,'1_sto_dev_wo_treaty')=.80*LandRHS_p('DapaoAg_u_f');
hectares_j_v.up('DapaoAg_u_f','Rice',t,'dry', 'CliStr_flow',m,'2_sto_dev_wi_treaty')=.75*LandRHS_p('DapaoAg_u_f');

hectares_j_v.up('NZzanAg_u_f','Rice',t,'dry', 'CliStr_flow',m,'1_sto_dev_wo_treaty')=.70*LandRHS_p('NZzanAg_u_f');
hectares_j_v.up('NZzanAg_u_f','Rice',t,'dry', 'CliStr_flow',m,'2_sto_dev_wi_treaty')=.68*LandRHS_p('NZzanAg_u_f');
*----------------------------------------------------------------------------------------------------------------


*-------------------------------------------*
* Cultural and habitat bounds right here
*Minimum Environmental Flow
X_v.lo('02_Nwokuy_v_f', t,k,s,m,p) = 200;
X_v.lo('03_Dapola_v_f', t,k,s,m,p) = 301;
X_v.lo('04_Noumb_v_f',  t,k,s,m,p) = 151;
X_v.lo('08_Komp_v_f',   t,k,s,m,p) = 64.5;
X_v.lo('12_Pwalugu_v_f',t,k,s,m,p) = 1317;    //42m3/s
X_v.lo('20_Kpong_v_f',  t,k,s,m,p) = 7889;
* end of cultural and habitat bounds
*------------------------------------------*

***************************************************************************************************
*Trade Policy Treaty flows                                                                        *
***************************************************************************************************
Ave_flow_v.lo('03_Dapola_v_f', k,'Histor_flow',m,p)= 1.0*Treaty_flow_Agree_p('03_Dapola_v_f', k,p);
Ave_flow_v.lo('03_Dapola_v_f', k,'CliStr_flow',m,p)= 0.7*Treaty_flow_Agree_p('03_Dapola_v_f', k,p);

Ave_flow_v.lo('04_Noumb_v_f',  k,'Histor_flow',m,p)= 1.0*Treaty_flow_Agree_p('04_Noumb_v_f',  k,p);
Ave_flow_v.lo('04_Noumb_v_f',  k,'CliStr_flow',m,p)= 0.7*Treaty_flow_Agree_p('04_Noumb_v_f',  k,p);

Ave_flow_v.lo('06_Bagre_v_f',  k,'Histor_flow',m,p)= 1.0*Treaty_flow_Agree_p('06_Bagre_v_f',  k,p);
Ave_flow_v.lo('06_Bagre_v_f',  k,'CliStr_flow',m,p)= 0.7*Treaty_flow_Agree_p('06_Bagre_v_f',  k,p);

Ave_flow_v.lo('09_Mango_v_f',  k,'Histor_flow',m,p)= 1.0*Treaty_flow_Agree_p('09_Mango_v_f',  k,p);
Ave_flow_v.lo('09_Mango_v_f',  k,'CliStr_flow',m,p)= 0.7*Treaty_flow_Agree_p('09_Mango_v_f',  k,p);

Ave_flow_v.lo('11_Nangodi_v_f',k,'Histor_flow',m,p)= 1.0*Treaty_flow_Agree_p('11_Nangodi_v_f',k,p);
Ave_flow_v.lo('11_Nangodi_v_f',k,'CliStr_flow',m,p)= 0.6*Treaty_flow_Agree_p('11_Nangodi_v_f',k,p);

* end of bounds on optimized variables

parameter
mod_stat_p(        k,s,m,p)  checks on feasibility and optimality         (Unitless)
mv_wat_p  (res,t,  k,s,m,p)  marginal value of water                      (Unitless)
;

* begin solving optimized model inside loops* -------------- begin loop ----------------------------------------------

*Solve starts here
$onempty
singleton set lpp(p) / /, lmm(m) / /,  lss(s) / /;

ss(s) = no;
mm(m) = no;
pp(p) = no;

* dummy solve to get .l initialized
Solve VOLTA_PROTOTYPE USING dNLP MAXIMIZING DNPV_looped_v;

$offempty

loop(p,
   loop(m,
      loop(s,
        pp(p) = yes;
        mm(m) = yes;
        ss(s) = yes;

* ------------------------------ Urban water use in the dry season must not reduce -----------------------------------

X_v.lo('OugaUr_u_f',t,'dry','CliStr_flow',m,p) = 0.99*X_v.l('OugaUr_u_f',t,'dry','Histor_flow',m,p);
X_v.lo('OugaUr_u_f',t,'wet','CliStr_flow',m,p) = 0.99*X_v.l('OugaUr_u_f',t,'wet','Histor_flow',m,p);

X_v.lo('BagrUr_u_f',t,'dry','CliStr_flow',m,p) = X_v.l('BagrUr_u_f',t,'dry','Histor_flow',m,p);
X_v.lo('BagrUr_u_f',t,'wet','CliStr_flow',m,p) = X_v.l('BagrUr_u_f',t,'wet','Histor_flow',m,p);

X_v.lo('BolgaUr_u_f',t,'dry','CliStr_flow',m,p)= X_v.l('BolgaUr_u_f',t,'dry','Histor_flow',m,p);
X_v.lo('BolgaUr_u_f',t,'wet','CliStr_flow',m,p)= X_v.l('BolgaUr_u_f',t,'wet','Histor_flow',m,p);

*----------------------------------------------------------------------------------------------------------------------------------------*
Urwatuse_r_v.l(t,'dry','01_Mali','CliStr_flow',m,'1_sto_dev_wo_treaty')= Urwatuse_r_v.l(t,'wet','01_Mali','CliStr_flow',m,'1_sto_dev_wo_treaty');
Urwatuse_r_v.l(t,'dry','01_Mali','CliStr_flow',m,'2_sto_dev_wi_treaty')= Urwatuse_r_v.l(t,'wet','01_Mali','CliStr_flow',m,'2_sto_dev_wi_treaty');

Urwatuse_r_v.l(t,'dry','01_Mali','Histor_flow',m,'1_sto_dev_wo_treaty')= Urwatuse_r_v.l(t,'wet','01_Mali','Histor_flow',m,'1_sto_dev_wo_treaty');
Urwatuse_r_v.l(t,'dry','01_Mali','Histor_flow',m,'2_sto_dev_wi_treaty')= Urwatuse_r_v.l(t,'wet','01_Mali','Histor_flow',m,'2_sto_dev_wi_treaty');

Urwatuse_r_v.l(t,'dry','02_BFASO','CliStr_flow',m,'1_sto_dev_wo_treaty')= Urwatuse_r_v.l(t,'wet','02_BFASO','CliStr_flow',m,'1_sto_dev_wo_treaty');
Urwatuse_r_v.l(t,'dry','02_BFASO','CliStr_flow',m,'2_sto_dev_wi_treaty')= Urwatuse_r_v.l(t,'wet','02_BFASO','CliStr_flow',m,'2_sto_dev_wi_treaty');

Urwatuse_r_v.l(t,'dry','02_BFASO','Histor_flow',m,'1_sto_dev_wo_treaty')= Urwatuse_r_v.l(t,'wet','02_BFASO','Histor_flow',m,'1_sto_dev_wo_treaty');
Urwatuse_r_v.l(t,'dry','02_BFASO','Histor_flow',m,'2_sto_dev_wi_treaty')= Urwatuse_r_v.l(t,'wet','02_BFASO','Histor_flow',m,'2_sto_dev_wi_treaty');

Urwatuse_r_v.l(t,'dry','03_Benin','CliStr_flow',m,'1_sto_dev_wo_treaty')= Urwatuse_r_v.l(t,'wet','03_Benin','CliStr_flow',m,'1_sto_dev_wo_treaty');
Urwatuse_r_v.l(t,'dry','03_Benin','CliStr_flow',m,'2_sto_dev_wi_treaty')= Urwatuse_r_v.l(t,'wet','03_Benin','CliStr_flow',m,'2_sto_dev_wi_treaty');

Urwatuse_r_v.l(t,'dry','03_Benin','Histor_flow',m,'1_sto_dev_wo_treaty')= Urwatuse_r_v.l(t,'wet','03_Benin','Histor_flow',m,'1_sto_dev_wo_treaty');
Urwatuse_r_v.l(t,'dry','03_Benin','Histor_flow',m,'2_sto_dev_wi_treaty')= Urwatuse_r_v.l(t,'wet','03_Benin','Histor_flow',m,'2_sto_dev_wi_treaty');

Urwatuse_r_v.l(t,k,'01_Mali','CliStr_flow',m,'1_sto_dev_wo_treaty')= Urwatuse_r_v.l(t,k,'01_Mali','Histor_flow',m,'1_sto_dev_wo_treaty');
Urwatuse_r_v.l(t,k,'01_Mali','CliStr_flow',m,'2_sto_dev_wi_treaty')= Urwatuse_r_v.l(t,k,'01_Mali','Histor_flow',m,'2_sto_dev_wi_treaty');

Urwatuse_r_v.l(t,k,'03_Benin','CliStr_flow',m,'1_sto_dev_wo_treaty')= Urwatuse_r_v.l(t,k,'03_Benin','Histor_flow',m,'1_sto_dev_wo_treaty');
Urwatuse_r_v.l(t,k,'03_Benin','CliStr_flow',m,'2_sto_dev_wi_treaty')= Urwatuse_r_v.l(t,k,'03_Benin','Histor_flow',m,'2_sto_dev_wi_treaty');

Urwatuse_r_v.l(t,k,'02_BFASO','CliStr_flow',m,'1_sto_dev_wo_treaty')= Urwatuse_r_v.l(t,k,'02_BFASO','Histor_flow',m,'1_sto_dev_wo_treaty');
Urwatuse_r_v.l(t,k,'02_BFASO','CliStr_flow',m,'2_sto_dev_wi_treaty')= Urwatuse_r_v.l(t,k,'02_BFASO','Histor_flow',m,'2_sto_dev_wi_treaty');

Urwatuse_r_v.l(t,k,'04_Togo','CliStr_flow',m,'1_sto_dev_wo_treaty')= Urwatuse_r_v.l(t,k,'04_Togo','Histor_flow',m,'1_sto_dev_wo_treaty');
Urwatuse_r_v.l(t,k,'04_Togo','CliStr_flow',m,'2_sto_dev_wi_treaty')= Urwatuse_r_v.l(t,k,'04_Togo','Histor_flow',m,'2_sto_dev_wi_treaty');

Urwatuse_r_v.l(t,k,'05_CIvoire','CliStr_flow',m,'1_sto_dev_wo_treaty')= Urwatuse_r_v.l(t,k,'05_CIvoire','Histor_flow',m,'1_sto_dev_wo_treaty');
Urwatuse_r_v.l(t,k,'05_CIvoire','CliStr_flow',m,'2_sto_dev_wi_treaty')= Urwatuse_r_v.l(t,k,'05_CIvoire','Histor_flow',m,'2_sto_dev_wi_treaty');

Urwatuse_r_v.l(t,k,'06_Ghana','CliStr_flow',m,'1_sto_dev_wo_treaty')= Urwatuse_r_v.l(t,k,'06_Ghana','Histor_flow',m,'1_sto_dev_wo_treaty');
Urwatuse_r_v.l(t,k,'06_Ghana','CliStr_flow',m,'2_sto_dev_wi_treaty')= Urwatuse_r_v.l(t,k,'06_Ghana','Histor_flow',m,'2_sto_dev_wi_treaty');

*----------------------------------------------------------------------------------------------------------------------------------------*
TotalUr_Ben_v.lo(r,'Histor_flow',m,'2_sto_dev_wi_treaty')= TotalUr_Ben_v.l (r,'Histor_flow',m,'1_sto_dev_wo_treaty');
TotalUr_Ben_v.lo(r,'CliStr_flow',m,'2_sto_dev_wi_treaty')= TotalUr_Ben_v.l (r,'CliStr_flow',m,'1_sto_dev_wo_treaty');

TotalUr_Ben_v.l('01_Mali','CliStr_flow',m,'1_sto_dev_wo_treaty')= TotalUr_Ben_v.l ('01_Mali','Histor_flow',m,'1_sto_dev_wo_treaty');
TotalUr_Ben_v.l('01_Mali','CliStr_flow',m,'2_sto_dev_wi_treaty')= TotalUr_Ben_v.l ('01_Mali','Histor_flow',m,'2_sto_dev_wi_treaty');

TotalUr_Ben_v.l('02_BFASO','CliStr_flow',m,'1_sto_dev_wo_treaty')= TotalUr_Ben_v.l ('02_BFASO','Histor_flow',m,'1_sto_dev_wo_treaty');
TotalUr_Ben_v.l('02_BFASO','CliStr_flow',m,'2_sto_dev_wi_treaty')= TotalUr_Ben_v.l ('02_BFASO','Histor_flow',m,'2_sto_dev_wi_treaty');

TotalUr_Ben_v.l('03_Benin','CliStr_flow',m,'1_sto_dev_wo_treaty')= TotalUr_Ben_v.l ('03_Benin','Histor_flow',m,'1_sto_dev_wo_treaty');
TotalUr_Ben_v.l('03_Benin','CliStr_flow',m,'2_sto_dev_wi_treaty')= TotalUr_Ben_v.l ('03_Benin','Histor_flow',m,'2_sto_dev_wi_treaty');

TotalUr_Ben_v.l('04_Togo','CliStr_flow',m,'1_sto_dev_wo_treaty')= TotalUr_Ben_v.l ('04_Togo','Histor_flow',m,'1_sto_dev_wo_treaty');
TotalUr_Ben_v.l('04_Togo','CliStr_flow',m,'2_sto_dev_wi_treaty')= TotalUr_Ben_v.l ('04_Togo','Histor_flow',m,'2_sto_dev_wi_treaty');

TotalUr_Ben_v.l('05_CIvoire','CliStr_flow',m,'1_sto_dev_wo_treaty')= TotalUr_Ben_v.l ('05_CIvoire','Histor_flow',m,'1_sto_dev_wo_treaty');
TotalUr_Ben_v.l('05_CIvoire','CliStr_flow',m,'2_sto_dev_wi_treaty')= TotalUr_Ben_v.l ('05_CIvoire','Histor_flow',m,'2_sto_dev_wi_treaty');

TotalUr_Ben_v.l('06_Ghana','CliStr_flow',m,'1_sto_dev_wo_treaty')= TotalUr_Ben_v.l ('06_Ghana','Histor_flow',m,'1_sto_dev_wo_treaty');
TotalUr_Ben_v.l('06_Ghana','CliStr_flow',m,'2_sto_dev_wi_treaty')= TotalUr_Ben_v.l ('06_Ghana','Histor_flow',m,'2_sto_dev_wi_treaty');
*----------------------------------------------------------------------------------------------------------------------------------------*

Solve VOLTA_PROTOTYPE USING dNLP MAXIMIZING DNPV_looped_v;
OPTION DNLP = conopt3;
mod_stat_p (      k,s,m,p) = VOLTA_PROTOTYPE.Modelstat + eps;

* closes loops below over s,m (water supply scenario and policy)

  lss(ss) = yes;
  lmm(mm) = yes;
  lpp(pp) = yes;

ss(s) = no;
mm(m) = no;
pp(p) = no;

          );
        );
      );



*Section 7. Displays
**************** Section 7 **************************************************************
*  The following section saves optimal solution(s) and displays results                 *
*****************************************************************************************
*CHECKS FOR WATER USES - AG AND URBAN AND RESERVIOR STOCKS
Parameter
check_wat_use_p   (use,t,k,  s,m,p)        check for difference between actual water use in countries and guages indication
check_wat_stock_p (res,t,k,  s,m,p)        check for the water in the reservoirs


;
*------------------------------------------------------------------------------------------------------------------------------------------------------------------------*                                            *
check_wat_stock_p ('02_LERY_res_s',t,k,s,m,p) $ (ord(t)  eq 1)  =  Z0_p('02_LERY_res_s') - Z_v.l('02_LERY_res_s','01',k,s,m,p) + eps;

check_wat_stock_p ('02_LERY_res_s',t,k,s,m,p) $ [(ord(k) * ord(t)) gt 1]  =   X_v.l('Sorou_h_f',t,k,s,m,p) + X_v.l('Dapola_h_f',t,k,s,m,p) + X_v.l('02_Nwokuy_v_f',t,k,s,m,p)- X_v.l('03_Dapola_v_f',t,k,s,m,p)
                                                            - X_v.l('NwokuyAg_d_f',t,k,s,m,p)- X_v.l('SorouMAg_d_f',t,k,s,m,p)- X_v.l('BanUr_d_f',t,k,s,m,p)- X_v.l('LSeourAg_d_f',t,k,s,m,p)- X_v.l('BoromoUr_d_f',t,k,s,m,p)
                                                            - X_v.l('SourouAg_d_f',t,k,s,m,p)+ X_v.l('NwokuyAg_r_f',t,k,s,m,p)+ X_v.l('SorouMAg_r_f',t,k,s,m,p)+ X_v.l('BanUr_r_f',t,k,s,m,p)+ X_v.l('LSeourAg_r_f',t,k,s,m,p)
                                                            + X_v.l('BoromoUr_r_f',t,k,s,m,p)+ X_v.l('SourouAg_r_f',t,k,s,m,p)- Z_v.l('02_LERY_res_s',t,k,s,m,p)
                                                            + sum[(t2,k2  ) $ linktime(t,k,t2,k2),Z_v.l('02_LERY_res_s',t2,k2,s,m,p)]- X_v.l('LERY_evap_f', t,k,s,m,p)+ X_v.l('LERY_precip_f', t,k,s,m,p)+ eps;
*------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_stock_p ('03_ZIGA_res_s',t,k,s,m,p) $ (ord(t)  eq 1)  =  Z0_p('03_ZIGA_res_s') - Z_v.l('03_ZIGA_res_s','01',k,s,m,p) + eps;

check_wat_stock_p ('03_ZIGA_res_s',t,k,s,m,p) $ [(ord(k) * ord(t)) gt 1]  = X_v.l('WhiteV_h_f',t,k,s,m,p)- X_v.l('05_Wayen_v_f',t,k,s,m,p)- X_v.l('KanozoAg_d_f',t,k,s,m,p)- X_v.l('LoumbAg_d_f',t,k,s,m,p)
                                                            + X_v.l('KanozoAg_r_f',t,k,s,m,p) + X_v.l('LoumbAg_r_f',t,k,s,m,p) - Z_v.l('03_ZIGA_res_s',t,k,s,m,p)
                                                            + sum[(t2,k2  ) $ linktime(t,k,t2,k2),Z_v.l('03_ZIGA_res_s',t2,k2,s,m,p)]- X_v.l('ZIGA_evap_f',t,k,s,m,p)+ X_v.l('ZIGA_precip_f', t,k,s,m,p) + eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_stock_p ('04_BAGRE_res_s',t,k,s,m,p) $ (ord(t)  eq 1) =  Z0_p('04_BAGRE_res_s') - Z_v.l('04_BAGRE_res_s','01',k,s,m,p) + eps;

check_wat_stock_p ('04_BAGRE_res_s',t,k,s,m,p) $ [(ord(k) * ord(t)) gt 1] =  X_v.l ('05_Wayen_v_f',t,k,s,m,p)+ X_v.l('White2_h_f',t,k,s,m,p)+ X_v.l('DMon_h_f',t,k,s,m,p)- X_v.l('06_Bagre_v_f',t,k,s,m,p)
                                                           - X_v.l('OugaUr_d_f',t,k,s,m,p)- X_v.l('TensoAg_d_f',t,k,s,m,p)+ X_v.l('OugaUr_r_f',t,k,s,m,p)+ X_v.l('TensoAg_r_f',t,k,s,m,p)
                                                           -Z_v.l('04_BAGRE_res_s',t,k,s,m,p)
                                                           + sum[(t2,k2) $ linktime(t,k,t2,k2),Z_v.l('04_BAGRE_res_s',t2,k2,s,m,p)] - X_v.l('BAGRE_evap_f',t,k,s,m,p)+ X_v.l('BAGRE_precip_f',t,k,s,m,p)+eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------*

check_wat_stock_p ('05_KOMP_res_s',t,k,s,m,p) $ (ord(t)  eq 1)  =  Z0_p('05_KOMP_res_s') - Z_v.l('05_KOMP_res_s','01',k,s,m,p) + eps;

check_wat_stock_p ('05_KOMP_res_s',t,k,s,m,p) $ [(ord(k) * ord(t)) gt 1]  =  X_v.l ('Komp_h_f',t,k,s,m,p)- X_v.l('08_Komp_v_f',t,k,s,m,p) - Z_v.l('05_KOMP_res_s',t,k,s,m,p)
                                                           + sum[(t2,k2) $ linktime(t,k,t2,k2),Z_v.l('05_KOMP_res_s',t2,k2,s,m,p)]- X_v.l('KOMP_evap_f', t,k,s,m,p) + X_v.l('KOMP_precip_f', t,k,s,m,p)+ eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------*

check_wat_stock_p ('06_TONO_res_s',t,k,s,m,p) $ (ord(t)  eq 1)  =  Z0_p('06_TONO_res_s') - Z_v.l('06_TONO_res_s','01',k,s,m,p) + eps;

check_wat_stock_p ('06_TONO_res_s',t,k,s,m,p) $ [(ord(k) * ord(t)) gt 1] =  X_v.l ('06_Bagre_v_f',t,k,s,m,p)+ X_v.l('11_Nangodi_v_f',t,k,s,m,p)+ X_v.l('Asibi_h_f',t,k,s,m,p)- X_v.l('12_Pwalugu_v_f',t,k,s,m,p)
                                                           - X_v.l('BagrUr_d_f',t,k,s,m,p)- X_v.l('BagreAg_d_f',t,k,s,m,p)- X_v.l('GoogAg_d_f',t,k,s,m,p)+X_v.l('PWALU_rel_f',t,k,s,m,p)
                                                           - X_v.l('TYaruAg_d_f',t,k,s,m,p)- X_v.l('TonoAg_d_f',t,k,s,m,p)- X_v.l('VeaAg_d_f',t,k,s,m,p)
                                                           - X_v.l('BolgaUr_d_f',t,k,s,m,p)+ X_v.l('BagrUr_r_f',t,k,s,m,p)+ X_v.l('BagreAg_r_f',t,k,s,m,p)
                                                           + X_v.l('GoogAg_r_f',t,k,s,m,p)+ X_v.l('TYaruAg_r_f',t,k,s,m,p)+ X_v.l('TonoAg_r_f',t,k,s,m,p)
                                                           + X_v.l('VeaAg_r_f',t,k,s,m,p)+ X_v.l('BolgaUr_r_f',t,k,s,m,p)- Z_v.l('06_TONO_res_s',t,k,s,m,p)
                                                           + sum[(t2,k2) $ linktime(t,k,t2,k2),Z_v.l('06_TONO_res_s',t2,k2,s,m,p)]- X_v.l('TONO_evap_f', t,k,s,m,p) + X_v.l('TONO_precip_f', t,k,s,m,p)+ eps;
*------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_stock_p ('07_PWALU_res_s',t,k,s,m,p) $ (ord(t)  eq 1)  =  Z0_p('07_PWALU_res_s') - Z_v.l('07_PWALU_res_s','01',k,s,m,p) + eps;

check_wat_stock_p ('07_PWALU_res_s',t,k,s,m,p) $ [(ord(k) * ord(t)) gt 1]  =  X_v.l ('06_Bagre_v_f',t,k,s,m,p)+ X_v.l('11_Nangodi_v_f',t,k,s,m,p)+ X_v.l('Asibi_h_f',t,k,s,m,p)- X_v.l('12_Pwalugu_v_f',t,k,s,m,p)
                                                           - X_v.l('BagrUr_d_f',t,k,s,m,p)- X_v.l('BagreAg_d_f',t,k,s,m,p)- X_v.l('GoogAg_d_f',t,k,s,m,p)+ X_v.l('TONO_rel_f',t,k,s,m,p)
                                                           - X_v.l('TYaruAg_d_f',t,k,s,m,p)- X_v.l('TonoAg_d_f',t,k,s,m,p)- X_v.l('VeaAg_d_f',t,k,s,m,p)
                                                           - X_v.l('BolgaUr_d_f',t,k,s,m,p)+ X_v.l('BagrUr_r_f',t,k,s,m,p)+ X_v.l('BagreAg_r_f',t,k,s,m,p)
                                                           + X_v.l('GoogAg_r_f',t,k,s,m,p)+ X_v.l('TYaruAg_r_f',t,k,s,m,p)+ X_v.l('TonoAg_r_f',t,k,s,m,p)
                                                           + X_v.l('VeaAg_r_f',t,k,s,m,p)+ X_v.l('BolgaUr_r_f',t,k,s,m,p)- Z_v.l('07_PWALU_res_s',t,k,s,m,p)
                                                           + sum[(t2,k2) $ linktime(t,k,t2,k2),Z_v.l('07_PWALU_res_s',t2,k2,s,m,p)]- X_v.l('PWALU_evap_f', t,k,s,m,p) + X_v.l('PWALU_precip_f', t,k,s,m,p)+ eps;
*------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_stock_p ('08_BUI_res_s',t,k,s,m,p) $ (ord(t)  eq 1)   =  Z0_p('08_BUI_res_s') - Z_v.l('08_BUI_res_s','01',k,s,m,p) + eps;

check_wat_stock_p ('08_BUI_res_s',t,k,s,m,p) $ [(ord(k) * ord(t)) gt 1]   =  X_v.l('04_Noumb_v_f',t,k,s,m,p)+ X_v.l('Tain_h_f',t,k,s,m,p)+ X_v.l('Bamba_h_f',t,k,s,m,p)+ X_v.l('Poni_h_f',t,k,s,m,p)- X_v.l('14_Bamboi_v_f',t,k,s,m,p)
                                                          - X_v.l('NoumbAg_d_f',t,k,s,m,p)- X_v.l('NZzanAg_d_f',t,k,s,m,p)- X_v.l('BounaUr_d_f',t,k,s,m,p)- X_v.l('BuiAg_d_f',t,k,s,m,p)
                                                          + X_v.l('NoumbAg_r_f',t,k,s,m,p)+ X_v.l('NZzanAg_r_f',t,k,s,m,p)+ X_v.l('BounaUr_r_f',t,k,s,m,p)+ X_v.l('BuiAg_r_f',t,k,s,m,p)
                                                          - Z_v.l('08_BUI_res_s',t,k,s,m,p)+ sum[(t2,k2) $ linktime(t,k,t2,k2),Z_v.l('08_BUI_res_s',t2,k2,s,m,p)]- X_v.l('BUI_evap_f',t,k,s,m,p) + X_v.l('BUI_precip_f',t,k,s,m,p) + eps;
*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_stock_p ('09_TANOSO_res_s',t,k,s,m,p)$(ord(t)  eq 1)  =  Z0_p('09_TANOSO_res_s') - Z_v.l('09_TANOSO_res_s','01',k,s,m,p) + eps;

check_wat_stock_p ('09_TANOSO_res_s',t,k,s,m,p)$[(ord(k) * ord(t)) gt 1]  =  X_v.l('Pru_h_f',t,k,s,m,p)- X_v.l('17_Prang_v_f',t,k,s,m,p)- X_v.l('TanosoAg_d_f',t,k,s,m,p)-X_v.l('AkumaAg_d_f',t,k,s,m,p)
                                                      + X_v.l('TanosoAg_r_f',t,k,s,m,p)+ X_v.l('AkumaAg_r_f',t,k,s,m,p)
                                                      - Z_v.l('09_TANOSO_res_s',t,k,s,m,p)+ sum[(t2,k2) $ linktime(t,k,t2,k2),Z_v.l('09_TANOSO_res_s',t2,k2,s,m,p)]- X_v.l('TANOSO_evap_f',t,k,s,m,p) +X_v.l('TANOSO_precip_f',t,k,s,m,p)+ eps;
*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_stock_p ('11_SUBIN_res_s',t,k,s,m,p) $ (ord(t)eq 1)   =  Z0_p('11_SUBIN_res_s') - Z_v.l('11_SUBIN_res_s','01',k,s,m,p) + eps;

check_wat_stock_p ('11_SUBIN_res_s',t,k,s,m,p) $ [(ord(k) * ord(t)) gt 1]   = X_v.l ('Subin_h_f',t,k,s,m,p)+ X_v.l('Mo_h_f',t,k,s,m,p)+ X_v.l('Mole_h_f',t,k,s,m,p)+ X_v.l('13_Nawuni_v_f',t,k,s,m,p)+ X_v.l('14_Bamboi_v_f',t,k,s,m,p)+ X_v.l('15_Sabari_v_f',t,k,s,m,p)
                                                              + X_v.l('17_Prang_v_f',t,k,s,m,p)+ X_v.l('16_Ekumdipe_v_f',t,k,s,m,p) - X_v.l('18_AkosomUp_v_f',t,k,s,m,p)- X_v.l('SubinjAg_d_f',t,k,s,m,p)- X_v.l('DipaliAg_d_f',t,k,s,m,p)- X_v.l('SogoAg_d_f',t,k,s,m,p)
                                                              - X_v.l('LibgaAg_d_f',t,k,s,m,p) - X_v.l('SavelUr_d_f',t,k,s,m,p)     - X_v.l('GolgaAg_d_f',t,k,s,m,p)    - X_v.l('BotangAg_d_f',t,k,s,m,p)- X_v.l('DaboAg_d_f',t,k,s,m,p)  - X_v.l('TamaleUr_d_f',t,k,s,m,p)
                                                              - X_v.l('YapeiAg_d_f',t,k,s,m,p) - X_v.l('NewLoAg_d_f',t,k,s,m,p)     - X_v.l('AsanKAg_d_f',t,k,s,m,p)    - X_v.l('BuipeAg_d_f',t,k,s,m,p) - X_v.l('DambUr_d_f',t,k,s,m,p)  + X_v.l('SubinjAg_r_f',t,k,s,m,p)
                                                              + X_v.l('DipaliAg_r_f',t,k,s,m,p)+ X_v.l('SogoAg_r_f',t,k,s,m,p)      + X_v.l('LibgaAg_r_f',t,k,s,m,p)    + X_v.l('SavelUr_r_f',t,k,s,m,p) + X_v.l('GolgaAg_r_f',t,k,s,m,p) + X_v.l('BotangAg_r_f',t,k,s,m,p)
                                                              + X_v.l('DaboAg_r_f',t,k,s,m,p)+ X_v.l('TamaleUr_r_f',t,k,s,m,p)      + X_v.l('YapeiAg_r_f',t,k,s,m,p)    + X_v.l('NewLoAg_r_f',t,k,s,m,p) + X_v.l('AsanKAg_r_f',t,k,s,m,p) + X_v.l('BuipeAg_r_f',t,k,s,m,p)
                                                              + X_v.l('DambUr_r_f',t,k,s,m,p)-Z_v.l('11_SUBIN_res_s',t,k,s,m,p)+ X_v.l('AMATE_rel_f',t,k,s,m,p)
                                                              + sum[(t2,k2) $ linktime(t,k,t2,k2),Z_v.l('11_SUBIN_res_s',t2,k2,s,m,p)]-X_v.l('SUBIN_evap_f',t,k,s,m,p)+X_v.l('SUBIN_precip_f',t,k,s,m,p)+eps;
*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_stock_p ('10_AMATE_res_s ',t,k,s,m,p) $ (ord(t)  eq 1) =  Z0_p('10_AMATE_res_s ') - Z_v.l('10_AMATE_res_s ','01',k,s,m,p) + eps;

check_wat_stock_p ('10_AMATE_res_s ',t,k,s,m,p) $ [(ord(k) * ord(t)) gt 1] = X_v.l ('Subin_h_f',t,k,s,m,p)+ X_v.l('Mo_h_f',t,k,s,m,p)+ X_v.l('Mole_h_f',t,k,s,m,p)+ X_v.l('13_Nawuni_v_f',t,k,s,m,p)+ X_v.l('14_Bamboi_v_f',t,k,s,m,p)+ X_v.l('15_Sabari_v_f',t,k,s,m,p)
                                                              + X_v.l('17_Prang_v_f',t,k,s,m,p)+ X_v.l('16_Ekumdipe_v_f',t,k,s,m,p) - X_v.l('18_AkosomUp_v_f',t,k,s,m,p)- X_v.l('SubinjAg_d_f',t,k,s,m,p)- X_v.l('DipaliAg_d_f',t,k,s,m,p)- X_v.l('SogoAg_d_f',t,k,s,m,p)
                                                              - X_v.l('LibgaAg_d_f',t,k,s,m,p) - X_v.l('SavelUr_d_f',t,k,s,m,p)     - X_v.l('GolgaAg_d_f',t,k,s,m,p)    - X_v.l('BotangAg_d_f',t,k,s,m,p)- X_v.l('DaboAg_d_f',t,k,s,m,p)  - X_v.l('TamaleUr_d_f',t,k,s,m,p)
                                                              - X_v.l('YapeiAg_d_f',t,k,s,m,p) - X_v.l('NewLoAg_d_f',t,k,s,m,p)     - X_v.l('AsanKAg_d_f',t,k,s,m,p)    - X_v.l('BuipeAg_d_f',t,k,s,m,p) - X_v.l('DambUr_d_f',t,k,s,m,p)  + X_v.l('SubinjAg_r_f',t,k,s,m,p)
                                                              + X_v.l('DipaliAg_r_f',t,k,s,m,p)+ X_v.l('SogoAg_r_f',t,k,s,m,p)      + X_v.l('LibgaAg_r_f',t,k,s,m,p)    + X_v.l('SavelUr_r_f',t,k,s,m,p) + X_v.l('GolgaAg_r_f',t,k,s,m,p) + X_v.l('BotangAg_r_f',t,k,s,m,p)
                                                              + X_v.l('DaboAg_r_f',t,k,s,m,p)+ X_v.l('TamaleUr_r_f',t,k,s,m,p)      + X_v.l('YapeiAg_r_f',t,k,s,m,p)    + X_v.l('NewLoAg_r_f',t,k,s,m,p) + X_v.l('AsanKAg_r_f',t,k,s,m,p) + X_v.l('BuipeAg_r_f',t,k,s,m,p)
                                                              + X_v.l('DambUr_r_f',t,k,s,m,p) - Z_v.l('10_AMATE_res_s ',t,k,s,m,p)+ X_v.l('SUBIN_rel_f',t,k,s,m,p)
                                                              + sum[(t2,k2) $ linktime(t,k,t2,k2), Z_v.l('10_AMATE_res_s ',t2,k2,s,m,p)]- X_v.l('AMATE_evap_f',t,k,s,m,p)+ X_v.l('AMATE_precip_f',t,k,s,m,p) + eps;
*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_stock_p ('12_LVOLTA_res_s',t,k,s,m,p) $ (ord(t)  eq 1) =  Z0_p('12_LVOLTA_res_s') - Z_v.l('12_LVOLTA_res_s','01',k,s,m,p) + eps;

check_wat_stock_p ('12_LVOLTA_res_s',t,k,s,m,p) $ [(ord(k) * ord(t)) gt 1] =   X_v.l('18_AkosomUp_v_f',t,k,s,m,p)+ X_v.l('Afram_h_f',t,k,s,m,p) - X_v.l('19_Senchi_v_f',t,k,s,m,p)- X_v.l('DedesoAg_d_f',t,k,s,m,p) - X_v.l('SataAg_d_f',t,k,s,m,p)
                                                              - X_v.l('KpandoAg_d_f',t,k,s,m,p)- X_v.l('AmateAg_d_f',t,k,s,m,p)
                                                            + X_v.l('DedesoAg_r_f',t,k,s,m,p)  + X_v.l('SataAg_r_f',t,k,s,m,p)+ X_v.l('KpandoAg_r_f',t,k,s,m,p)+ X_v.l('AmateAg_r_f',t,k,s,m,p) + X_v.l('Tod_h_f',t,k,s,m,p)
                                                 - Z_v.l('12_LVOLTA_res_s',t,k,s,m,p) + sum[(t2,k2) $ linktime(t,k,t2,k2),Z_v.l('12_LVOLTA_res_s',t2,k2,s,m,p)]- X_v.l('LVOLTA_evap_f',t,k,s,m,p) +X_v.l('LVOLTA_precip_f',t,k,s,m,p)+ eps;
*----------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_stock_p ('13_KPONG_res_s',t,k,s,m,p) $ (ord(t)  eq 1)  =   Z0_p('13_KPONG_res_s') - Z_v.l('13_KPONG_res_s','01',k,s,m,p) + eps;

check_wat_stock_p ('13_KPONG_res_s',t,k,s,m,p) $ [(ord(k) * ord(t)) gt 1]= X_v.l('19_Senchi_v_f',t,k,s,m,p)- X_v.l('20_Kpong_v_f',t,k,s,m,p)-X_v.l('KpongAg_d_f',t,k,s,m,p)-X_v.l('AveyimAg_d_f',t,k,s,m,p)
                                                       - X_v.l('AccraUr_d_f',t,k,s,m,p)-X_v.l('AfifeAg_d_f',t,k,s,m,p)+X_v.l('KpongAg_r_f',t,k,s,m,p)+X_v.l('AveyimAg_r_f',t,k,s,m,p)
                                                       + X_v.l('AccraUr_r_f',t,k,s,m,p) + X_v.l('AfifeAg_r_f',t,k,s,m,p)- Z_v.l('13_KPONG_res_s',t,k,s,m,p)
                                                       +sum[(t2,k2) $ linktime(t,k,t2,k2),Z_v.l('13_KPONG_res_s',t2,k2,s,m,p)]- X_v.l('KPONG_evap_f',t,k,s,m,p) +X_v.l('KPONG_precip_f',t,k,s,m,p)+ eps;
***********************************************************************************************************************************************************************************************************************************************

check_wat_use_p('BoboDUr_u_f',t,k,s,m,p)  = X_v.l('BVSame_h_f',t,k,s,m,p)- X_v.l('01_Samen_v_f',t,k,s,m,p)- X_v.l('BoboDUr_u_f',t,k,s,m,p) + X_v.l('SAMEN_rel_f',t,k,s,m,p)+ eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('SamenAg_u_f',t,k,s,m,p)  = X_v.l('Nwok_h_f',t,k,s,m,p) + X_v.l('01_Samen_v_f',t,k,s,m,p) -  X_v.l('02_Nwokuy_v_f',t,k,s,m,p)- sum((j), hectares_j_v.l('SamenAg_u_f',j,t,k,s,m,p)* Bu_p('SamenAg_u_f',j,k)) + eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('NwokuyAg_u_f',t,k,s,m,p) = X_v.l('Sorou_h_f',t,k,s,m,p) + X_v.l('Dapola_h_f',t,k,s,m,p)  + X_v.l('02_Nwokuy_v_f',t,k,s,m,p) - X_v.l('03_Dapola_v_f',t,k,s,m,p)- X_v.l('SourouAg_d_f',t,k,s,m,p)- X_v.l('SorouMAg_d_f',t,k,s,m,p)
                                        - X_v.l('BanUr_d_f',t,k,s,m,p) - X_v.l('LSeourAg_d_f',t,k,s,m,p)- X_v.l('BoromoUr_d_f',t,k,s,m,p)+ X_v.l('SourouAg_r_f',t,k,s,m,p)  + X_v.l('SorouMAg_r_f',t,k,s,m,p)+ X_v.l('BanUr_r_f',t,k,s,m,p)
                                        + X_v.l('LSeourAg_r_f',t,k,s,m,p) + X_v.l('BoromoUr_r_f',t,k,s,m,p)+ X_v.l('LERY_rel_f',t,k,s,m,p)- sum((j), hectares_j_v.l('NwokuyAg_u_f',j,t,k,s,m,p)* Bu_p('NwokuyAg_u_f',j,k)) + eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('SourouAg_u_f',t,k,s,m,p) = X_v.l('Sorou_h_f',t,k,s,m,p) + X_v.l('Dapola_h_f',t,k,s,m,p)  + X_v.l('02_Nwokuy_v_f',t,k,s,m,p) - X_v.l('03_Dapola_v_f',t,k,s,m,p)- X_v.l('NwokuyAg_d_f',t,k,s,m,p)- X_v.l('SorouMAg_d_f',t,k,s,m,p)
                                        - X_v.l('BanUr_d_f',t,k,s,m,p) - X_v.l('LSeourAg_d_f',t,k,s,m,p)- X_v.l('BoromoUr_d_f',t,k,s,m,p)  + X_v.l('NwokuyAg_r_f',t,k,s,m,p) + X_v.l('SorouMAg_r_f',t,k,s,m,p) + X_v.l('BanUr_r_f',t,k,s,m,p)
                                        + X_v.l('LSeourAg_r_f',t,k,s,m,p) + X_v.l('BoromoUr_r_f',t,k,s,m,p)+ X_v.l('LERY_rel_f',t,k,s,m,p)- sum((j), hectares_j_v.l('SourouAg_u_f',j,t,k,s,m,p)* Bu_p('SourouAg_u_f',j,k)) + eps;
*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('SorouMAg_u_f',t,k,s,m,p) = X_v.l('Sorou_h_f',t,k,s,m,p) + X_v.l('Dapola_h_f',t,k,s,m,p)  + X_v.l('02_Nwokuy_v_f',t,k,s,m,p) - X_v.l('03_Dapola_v_f',t,k,s,m,p)- X_v.l('NwokuyAg_d_f',t,k,s,m,p)- X_v.l('SourouAg_d_f',t,k,s,m,p)
                                        - X_v.l('BanUr_d_f',t,k,s,m,p) - X_v.l('LSeourAg_d_f',t,k,s,m,p)- X_v.l('BoromoUr_d_f',t,k,s,m,p)+ X_v.l('NwokuyAg_r_f',t,k,s,m,p) + X_v.l('SourouAg_r_f',t,k,s,m,p)+ X_v.l('BanUr_r_f',t,k,s,m,p)
                                        + X_v.l('LSeourAg_r_f',t,k,s,m,p)+X_v.l('BoromoUr_r_f',t,k,s,m,p)+ X_v.l('LERY_rel_f',t,k,s,m,p)- sum((j), hectares_j_v.l('SorouMAg_u_f',j,t,k,s,m,p)* Bu_p('SorouMAg_u_f',j,k)) + eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('BanUr_u_f',t,k,s,m,p)    = X_v.l('Sorou_h_f',t,k,s,m,p) + X_v.l('Dapola_h_f',t,k,s,m,p)  + X_v.l('02_Nwokuy_v_f',t,k,s,m,p) - X_v.l('03_Dapola_v_f',t,k,s,m,p)- X_v.l('NwokuyAg_d_f',t,k,s,m,p)- X_v.l('SourouAg_d_f',t,k,s,m,p)
                                        - X_v.l('SorouMAg_d_f',t,k,s,m,p) - X_v.l('LSeourAg_d_f',t,k,s,m,p)- X_v.l('BoromoUr_d_f',t,k,s,m,p) + X_v.l('NwokuyAg_r_f',t,k,s,m,p) + X_v.l('SourouAg_r_f',t,k,s,m,p)+ X_v.l('SorouMAg_r_f',t,k,s,m,p)
                                        + X_v.l('LSeourAg_r_f',t,k,s,m,p)+X_v.l('BoromoUr_r_f',t,k,s,m,p) - X_v.l('BanUr_u_f',t,k,s,m,p)+ X_v.l('LERY_rel_f',t,k,s,m,p) + eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('LSeourAg_u_f',t,k,s,m,p) = X_v.l('Sorou_h_f',t,k,s,m,p) + X_v.l('Dapola_h_f',t,k,s,m,p) + X_v.l('02_Nwokuy_v_f',t,k,s,m,p)- X_v.l('03_Dapola_v_f',t,k,s,m,p)- X_v.l('NwokuyAg_d_f',t,k,s,m,p)- X_v.l('SourouAg_d_f',t,k,s,m,p)
                                        - X_v.l('SorouMAg_d_f',t,k,s,m,p)- X_v.l('BanUr_d_f',t,k,s,m,p)- X_v.l('BoromoUr_d_f',t,k,s,m,p)+ X_v.l('NwokuyAg_r_f',t,k,s,m,p) + X_v.l('SourouAg_r_f',t,k,s,m,p)+ X_v.l('SorouMAg_r_f',t,k,s,m,p)
                                        + X_v.l('BanUr_r_f',t,k,s,m,p)  + X_v.l('BoromoUr_r_f',t,k,s,m,p)- sum((j), hectares_j_v.l('LSeourAg_u_f',j,t,k,s,m,p)* Bu_p('LSeourAg_u_f',j,k)) + X_v.l('LERY_rel_f',t,k,s,m,p)+ eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('BoromoUr_u_f',t,k,s,m,p) = X_v.l('Sorou_h_f',t,k,s,m,p)+ X_v.l('Dapola_h_f',t,k,s,m,p)+ X_v.l('02_Nwokuy_v_f',t,k,s,m,p)- X_v.l('03_Dapola_v_f',t,k,s,m,p)- X_v.l('NwokuyAg_d_f',t,k,s,m,p)- X_v.l('SourouAg_d_f',t,k,s,m,p)
                                        - X_v.l('SorouMAg_d_f',t,k,s,m,p)- X_v.l('BanUr_d_f',t,k,s,m,p)- X_v.l('LSeourAg_d_f',t,k,s,m,p)+ X_v.l('NwokuyAg_r_f',t,k,s,m,p)+ X_v.l('SourouAg_r_f',t,k,s,m,p)
                                        + X_v.l('SorouMAg_r_f',t,k,s,m,p)+ X_v.l('BanUr_r_f',t,k,s,m,p)+ X_v.l('LSeourAg_r_f',t,k,s,m,p)- X_v.l('BoromoUr_u_f',t,k,s,m,p) + X_v.l('LERY_rel_f',t,k,s,m,p)+ eps;
*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('DapolaAg_u_f',t,k,s,m,p) = X_v.l('03_Dapola_v_f',t,k,s,m,p) + X_v.l('Bouga_h_f',t,k,s,m,p) - X_v.l('04_Noumb_v_f',t,k,s,m,p)- X_v.l('GaouaUr_d_f',t,k,s,m,p)- X_v.l('BagriAg_d_f',t,k,s,m,p)- X_v.l('DuuliAg_d_f',t,k,s,m,p)
                                        - X_v.l('WaUr_d_f',t,k,s,m,p)  + X_v.l('GaouaUr_r_f',t,k,s,m,p) + X_v.l('BagriAg_r_f',t,k,s,m,p)+ X_v.l('DuuliAg_r_f',t,k,s,m,p)+ X_v.l('WaUr_r_f',t,k,s,m,p)
                                        - sum((j), hectares_j_v.l('DapolaAg_u_f',j,t,k,s,m,p)* Bu_p('DapolaAg_u_f',j,k)) + eps;
*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('GaouaUr_u_f',t,k,s,m,p)  = X_v.l('03_Dapola_v_f',t,k,s,m,p)+ X_v.l('Bouga_h_f',t,k,s,m,p)  - X_v.l('04_Noumb_v_f',t,k,s,m,p)- X_v.l('DapolaAg_d_f',t,k,s,m,p)- X_v.l('BagriAg_d_f',t,k,s,m,p)- X_v.l('DuuliAg_d_f',t,k,s,m,p)
                                          - X_v.l('WaUr_d_f',t,k,s,m,p) + X_v.l('DapolaAg_r_f',t,k,s,m,p)+ X_v.l('BagriAg_r_f',t,k,s,m,p)+ X_v.l('DuuliAg_r_f',t,k,s,m,p)+ X_v.l('WaUr_r_f',t,k,s,m,p)- X_v.l('GaouaUr_u_f',t,k,s,m,p)+ eps;
*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('NoumbAg_u_f',t,k,s,m,p)  = X_v.l('Tain_h_f',t,k,s,m,p)+X_v.l('Bamba_h_f',t,k,s,m,p)+ X_v.l('Poni_h_f',t,k,s,m,p)+X_v.l('04_Noumb_v_f',t,k,s,m,p)- X_v.l('14_Bamboi_v_f',t,k,s,m,p)- X_v.l('BuiAg_d_f',t,k,s,m,p)-X_v.l('NZzanAg_d_f',t,k,s,m,p)
               + X_v.l('NZzanAg_r_f',t,k,s,m,p)- X_v.l('BounaUr_d_f',t,k,s,m,p)+ X_v.l('BounaUr_r_f',t,k,s,m,p)+X_v.l('BuiAg_r_f',t,k,s,m,p) + X_v.l('BUI_rel_f',t,k,s,m,p)- sum((j), hectares_j_v.l('NoumbAg_u_f',j,t,k,s,m,p)* Bu_p('NoumbAg_u_f',j,k)) + eps;
*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('KanozoAg_u_f',t,k,s,m,p) = X_v.l('WhiteV_h_f', t,k,s,m,p) - X_v.l('05_Wayen_v_f',t,k,s,m,p)- X_v.l('LoumbAg_d_f',t,k,s,m,p) + X_v.l('LoumbAg_r_f',t,k,s,m,p) + X_v.l('ZIGA_rel_f',t,k,s,m,p)
                                        - sum((j), hectares_j_v.l('KanozoAg_u_f',j,t,k,s,m,p)* Bu_p('KanozoAg_u_f',j,k)) + eps;
*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('LoumbAg_u_f',t,k,s,m,p)  = X_v.l('WhiteV_h_f', t,k,s,m,p) - X_v.l('05_Wayen_v_f',t,k,s,m,p)- X_v.l('KanozoAg_d_f',t,k,s,m,p) + X_v.l('KanozoAg_r_f',t,k,s,m,p)+ X_v.l('ZIGA_rel_f',t,k,s,m,p)
                                        - sum((j),hectares_j_v.l('LoumbAg_u_f',j,t,k,s,m,p)* Bu_p('LoumbAg_u_f',j,k)) + eps;
*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('OugaUr_u_f',t,k,s,m,p)   = X_v.l('05_Wayen_v_f',t,k,s,m,p)+ X_v.l('White2_h_f',t,k,s,m,p)+ X_v.l('DMon_h_f',t,k,s,m,p) - X_v.l('06_Bagre_v_f',t,k,s,m,p) - X_v.l('TensoAg_d_f',t,k,s,m,p)+ X_v.l('TensoAg_r_f',t,k,s,m,p)
                                        + X_v.l('BAGRE_rel_f',t,k,s,m,p)- X_v.l('OugaUr_u_f',t,k,s,m,p)+ eps;
*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('TensoAg_u_f',t,k,s,m,p)  = X_v.l('05_Wayen_v_f',t,k,s,m,p) +X_v.l('White2_h_f',t,k,s,m,p)+ X_v.l('DMon_h_f',t,k,s,m,p)- X_v.l('06_Bagre_v_f',t,k,s,m,p) - X_v.l('OugaUr_d_f',t,k,s,m,p)
                                        + X_v.l('OugaUr_r_f',t,k,s,m,p)+ X_v.l('BAGRE_rel_f',t,k,s,m,p)- sum((j), hectares_j_v.l('TensoAg_u_f',j,t,k,s,m,p)* Bu_p('TensoAg_u_f',j,k)) + eps;
*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('KompeUr_u_f',t,k,s,m,p)  = X_v.l('Oti_h_f',t,k,s,m,p)+ X_v.l('07_Arly_v_f',t,k,s,m,p) + X_v.l('08_Komp_v_f',t,k,s,m,p)- X_v.l('09_Mango_v_f',t,k,s,m,p)-X_v.l('PorgaAg_d_f',t,k,s,m,p)- X_v.l('MeteUr_d_f',t,k,s,m,p)
                                        - X_v.l('DapoUr_d_f',t,k,s,m,p)- X_v.l('DapaoAg_d_f',t,k,s,m,p)
                                        + X_v.l('PorgaAg_r_f ',t,k,s,m,p)+ X_v.l('MeteUr_r_f',t,k,s,m,p)+ X_v.l('DapoUr_r_f',t,k,s,m,p) + X_v.l('DapaoAg_r_f',t,k,s,m,p) - X_v.l('KompeUr_u_f',t,k,s,m,p)+ eps;
*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('PorgaAg_u_f',t,k,s,m,p)  = X_v.l('07_Arly_v_f',t,k,s,m,p)+ X_v.l('Oti_h_f',t,k,s,m,p)+ X_v.l('08_Komp_v_f',t,k,s,m,p) - X_v.l('09_Mango_v_f',t,k,s,m,p)-X_v.l('MeteUr_d_f',t,k,s,m,p)- X_v.l('DapoUr_d_f',t,k,s,m,p)
                                        - X_v.l('DapaoAg_d_f',t,k,s,m,p)- X_v.l('KompeUr_d_f',t,k,s,m,p)+ X_v.l('MeteUr_r_f',t,k,s,m,p) + X_v.l('DapaoAg_r_f',t,k,s,m,p)+ X_v.l('DapoUr_r_f',t,k,s,m,p)+ X_v.l('KompeUr_r_f',t,k,s,m,p)
                                        - sum((j), hectares_j_v.l('PorgaAg_u_f',j,t,k,s,m,p)* Bu_p('PorgaAg_u_f',j,k)) + eps;
*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('MeteUr_u_f',t,k,s,m,p)   = X_v.l('07_Arly_v_f',t,k,s,m,p)+ X_v.l('Oti_h_f',t,k,s,m,p)+ X_v.l('08_Komp_v_f',t,k,s,m,p)- X_v.l('09_Mango_v_f',t,k,s,m,p)- X_v.l('PorgaAg_d_f',t,k,s,m,p)- X_v.l('DapoUr_d_f',t,k,s,m,p)
                                        - X_v.l('DapaoAg_d_f',t,k,s,m,p) - X_v.l('KompeUr_d_f',t,k,s,m,p)+ X_v.l('PorgaAg_r_f',t,k,s,m,p)+ X_v.l('DapaoAg_r_f',t,k,s,m,p)+ X_v.l('DapoUr_r_f',t,k,s,m,p) + X_v.l('KompeUr_r_f',t,k,s,m,p)
                                        - X_v.l('MeteUr_u_f',t,k,s,m,p)+ eps;
*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('DapaoAg_u_f',t,k,s,m,p)  = X_v.l('07_Arly_v_f',t,k,s,m,p)+ X_v.l('Oti_h_f',t,k,s,m,p) + X_v.l('08_Komp_v_f',t,k,s,m,p) - X_v.l('09_Mango_v_f',t,k,s,m,p)- X_v.l('PorgaAg_d_f',t,k,s,m,p)- X_v.l('MeteUr_d_f',t,k,s,m,p)
                                        - X_v.l('DapoUr_d_f',t,k,s,m,p)- X_v.l('KompeUr_d_f',t,k,s,m,p)+ X_v.l('PorgaAg_r_f',t,k,s,m,p)+ X_v.l('MeteUr_r_f',t,k,s,m,p)+ X_v.l('DapoUr_r_f',t,k,s,m,p)+ X_v.l('KompeUr_r_f',t,k,s,m,p)
                                        - sum((j), hectares_j_v.l('DapaoAg_u_f',j,t,k,s,m,p)* Bu_p('DapaoAg_u_f',j,k)) + eps;
*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('SaviliAg_u_f',t,k,s,m,p) = X_v.l('RedV_h_f',t,k,s,m,p)- X_v.l('11_Nangodi_v_f',t,k,s,m,p)- X_v.l('NangoAg_d_f',t,k,s,m,p)+ X_v.l('NangoAg_r_f',t,k,s,m,p)- sum((j), hectares_j_v.l('SaviliAg_u_f',j,t,k,s,m,p)* Bu_p('SaviliAg_u_f',j,k)) + eps;
*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('NangoAg_u_f',t,k,s,m,p)  = X_v.l('RedV_h_f',t,k,s,m,p)- X_v.l('11_Nangodi_v_f',t,k,s,m,p)- X_v.l('SaviliAg_d_f',t,k,s,m,p)+ X_v.l('SaviliAg_r_f',t,k,s,m,p)-sum((j),hectares_j_v.l('NangoAg_u_f',j,t,k,s,m,p)*Bu_p('NangoAg_u_f',j,k)) + eps;
*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('BagreAg_u_f',t,k,s,m,p)  = X_v.l('06_Bagre_v_f',t,k,s,m,p)+X_v.l('11_Nangodi_v_f',t,k,s,m,p)+X_v.l('Asibi_h_f',t,k,s,m,p)-X_v.l('12_Pwalugu_v_f',t,k,s,m,p)-X_v.l('BagrUr_d_f',t,k,s,m,p)-X_v.l('GoogAg_d_f',t,k,s,m,p)- X_v.l('TYaruAg_d_f',t,k,s,m,p)
                                        - X_v.l('VeaAg_d_f',t,k,s,m,p)- X_v.l('TonoAg_d_f',t,k,s,m,p)- X_v.l('BolgaUr_d_f',t,k,s,m,p)+ X_v.l('BagrUr_r_f',t,k,s,m,p)+ X_v.l('GoogAg_r_f',t,k,s,m,p)+ X_v.l('TYaruAg_r_f',t,k,s,m,p) + X_v.l('VeaAg_r_f',t,k,s,m,p)
                                        + X_v.l('BolgaUr_r_f',t,k,s,m,p)+ X_v.l('TonoAg_r_f',t,k,s,m,p)+ X_v.l('PWALU_rel_f',t,k,s,m,p)+X_v.l('TONO_rel_f',t,k,s,m,p)- sum((j), hectares_j_v.l('BagreAg_u_f',j,t,k,s,m,p)* Bu_p('BagreAg_u_f',j,k)) + eps;
*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('BagrUr_u_f',t,k,s,m,p)   = X_v.l('06_Bagre_v_f',t,k,s,m,p)+X_v.l('11_Nangodi_v_f',t,k,s,m,p)+X_v.l('Asibi_h_f',t,k,s,m,p)-X_v.l('12_Pwalugu_v_f',t,k,s,m,p)-X_v.l('BagreAg_d_f',t,k,s,m,p)-X_v.l('GoogAg_d_f',t,k,s,m,p)-X_v.l('TYaruAg_d_f',t,k,s,m,p)
                                        - X_v.l('VeaAg_d_f',t,k,s,m,p)-X_v.l('TonoAg_d_f',t,k,s,m,p) - X_v.l('BolgaUr_d_f',t,k,s,m,p) + X_v.l('BagreAg_r_f',t,k,s,m,p)+ X_v.l('GoogAg_r_f',t,k,s,m,p)  + X_v.l('TYaruAg_r_f',t,k,s,m,p) + X_v.l('VeaAg_r_f',t,k,s,m,p)
                                        + X_v.l('TonoAg_r_f',t,k,s,m,p)+ X_v.l('BolgaUr_r_f',t,k,s,m,p)+ X_v.l('PWALU_rel_f',t,k,s,m,p)+ X_v.l('TONO_rel_f',t,k,s,m,p)- X_v.l('BagrUr_u_f',t,k,s,m,p) + eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('NZzanAg_u_f',t,k,s,m,p)  = X_v.l('Tain_h_f',t,k,s,m,p)+X_v.l('04_Noumb_v_f',t,k,s,m,p)+X_v.l('Poni_h_f',t,k,s,m,p)+X_v.l('Bamba_h_f',t,k,s,m,p) - X_v.l('14_Bamboi_v_f',t,k,s,m,p)- X_v.l('BuiAg_d_f',t,k,s,m,p)- X_v.l('BounaUr_d_f',t,k,s,m,p)-X_v.l('NoumbAg_d_f',t,k,s,m,p)
                                          + X_v.l('BounaUr_r_f',t,k,s,m,p)+X_v.l('BuiAg_r_f',t,k,s,m,p)+X_v.l('NoumbAg_r_f',t,k,s,m,p) + X_v.l('BUI_rel_f',t,k,s,m,p)- sum((j),hectares_j_v.l('NZzanAg_u_f',j,t,k,s,m,p)* Bu_p('NZzanAg_u_f',j,k)) + eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('BounaUr_u_f',t,k,s,m,p)  = X_v.l('04_Noumb_v_f',t,k,s,m,p) +X_v.l('Tain_h_f',t,k,s,m,p)+X_v.l('Poni_h_f',t,k,s,m,p)- X_v.l('14_Bamboi_v_f',t,k,s,m,p)- X_v.l('BuiAg_d_f',t,k,s,m,p)- X_v.l('NZzanAg_d_f',t,k,s,m,p)+ X_v.l('NZzanAg_r_f',t,k,s,m,p)
                                          -X_v.l('NoumbAg_d_f',t,k,s,m,p) + X_v.l('BuiAg_r_f',t,k,s,m,p)+X_v.l('NoumbAg_r_f',t,k,s,m,p)+X_v.l('Bamba_h_f',t,k,s,m,p)+ X_v.l('BUI_rel_f',t,k,s,m,p)- X_v.l('BounaUr_u_f',t,k,s,m,p) + eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('BagriAg_u_f',t,k,s,m,p)  = X_v.l('03_Dapola_v_f',t,k,s,m,p)+ X_v.l('Bouga_h_f',t,k,s,m,p)-X_v.l('04_Noumb_v_f',t,k,s,m,p)- X_v.l('GaouaUr_d_f',t,k,s,m,p)- X_v.l('WaUr_d_f',t,k,s,m,p)- X_v.l('DuuliAg_d_f',t,k,s,m,p)- X_v.l('DapolaAg_d_f',t,k,s,m,p)
                                 + X_v.l('GaouaUr_r_f',t,k,s,m,p)+ X_v.l('DapolaAg_r_f',t,k,s,m,p)+ X_v.l('DuuliAg_r_f',t,k,s,m,p)+ X_v.l('WaUr_r_f',t,k,s,m,p)- sum((j), hectares_j_v.l('BagriAg_u_f',j,t,k,s,m,p)* Bu_p('BagriAg_u_f',j,k)) + eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('DuuliAg_u_f',t,k,s,m,p)  = X_v.l('03_Dapola_v_f',t,k,s,m,p)+ X_v.l('Bouga_h_f',t,k,s,m,p)-X_v.l('04_Noumb_v_f',t,k,s,m,p)- X_v.l('GaouaUr_d_f',t,k,s,m,p)- X_v.l('BagriAg_d_f',t,k,s,m,p)- X_v.l('DapolaAg_d_f',t,k,s,m,p)- X_v.l('WaUr_d_f',t,k,s,m,p)
                                        + X_v.l('GaouaUr_r_f',t,k,s,m,p)+ X_v.l('BagriAg_r_f',t,k,s,m,p)+ X_v.l('DapolaAg_r_f',t,k,s,m,p)+ X_v.l('WaUr_r_f',t,k,s,m,p)- sum((j), hectares_j_v.l('DuuliAg_u_f',j,t,k,s,m,p)* Bu_p('DuuliAg_u_f',j,k)) + eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('WaUr_u_f',t,k,s,m,p)= X_v.l('03_Dapola_v_f',t,k,s,m,p) + X_v.l('Bouga_h_f',t,k,s,m,p) - X_v.l('04_Noumb_v_f',t,k,s,m,p)- X_v.l('GaouaUr_d_f',t,k,s,m,p)- X_v.l('BagriAg_d_f',t,k,s,m,p)- X_v.l('DuuliAg_d_f',t,k,s,m,p)
                                   - X_v.l('DapolaAg_d_f',t,k,s,m,p)  + X_v.l('GaouaUr_r_f',t,k,s,m,p) + X_v.l('BagriAg_r_f',t,k,s,m,p)+ X_v.l('DuuliAg_r_f',t,k,s,m,p)+ X_v.l('DapolaAg_r_f',t,k,s,m,p)- X_v.l('WaUr_u_f',t,k,s,m,p)+ eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('TonoAg_u_f',t,k,s,m,p)= X_v.l('06_Bagre_v_f',t,k,s,m,p) + X_v.l('11_Nangodi_v_f',t,k,s,m,p)+ X_v.l('Asibi_h_f',t,k,s,m,p)- X_v.l('12_Pwalugu_v_f',t,k,s,m,p)-X_v.l('BagrUr_d_f',t,k,s,m,p)-X_v.l('BagreAg_d_f',t,k,s,m,p)+X_v.l('BagreAg_r_f',t,k,s,m,p)
                                   + X_v.l('BagrUr_r_f',t,k,s,m,p)- X_v.l('GoogAg_d_f',t,k,s,m,p)- X_v.l('TYaruAg_d_f',t,k,s,m,p)- X_v.l('VeaAg_d_f',t,k,s,m,p)- X_v.l('BolgaUr_d_f',t,k,s,m,p)  + X_v.l('VeaAg_r_f',t,k,s,m,p)+ X_v.l('BolgaUr_r_f',t,k,s,m,p)
                                   + X_v.l('TONO_rel_f',t,k,s,m,p)+ X_v.l('GoogAg_r_f',t,k,s,m,p)+X_v.l('TYaruAg_r_f',t,k,s,m,p)+ X_v.l('PWALU_rel_f',t,k,s,m,p)- sum((j),hectares_j_v.l('TonoAg_u_f',j,t,k,s,m,p)* Bu_p('TonoAg_u_f',j,k)) + eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('VeaAg_u_f',t,k,s,m,p) = X_v.l('06_Bagre_v_f',t,k,s,m,p) + X_v.l('11_Nangodi_v_f',t,k,s,m,p)+ X_v.l('Asibi_h_f',t,k,s,m,p)- X_v.l('12_Pwalugu_v_f',t,k,s,m,p)-X_v.l('BagrUr_d_f',t,k,s,m,p)-X_v.l('BagreAg_d_f',t,k,s,m,p)+X_v.l('BagreAg_r_f',t,k,s,m,p)
                                     + X_v.l('BagrUr_r_f',t,k,s,m,p)- X_v.l('GoogAg_d_f',t,k,s,m,p)- X_v.l('TYaruAg_d_f',t,k,s,m,p) - X_v.l('TonoAg_d_f',t,k,s,m,p)- X_v.l('BolgaUr_d_f',t,k,s,m,p)  + X_v.l('TonoAg_r_f',t,k,s,m,p)+ X_v.l('BolgaUr_r_f',t,k,s,m,p)
                                     + X_v.l('TONO_rel_f',t,k,s,m,p)+X_v.l('GoogAg_r_f',t,k,s,m,p)+X_v.l('TYaruAg_r_f',t,k,s,m,p)+ X_v.l('PWALU_rel_f',t,k,s,m,p)- sum((j),hectares_j_v.l('VeaAg_u_f',j,t,k,s,m,p)* Bu_p('VeaAg_u_f',j,k))+eps;
*----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('GoogAg_u_f',t,k,s,m,p) = X_v.l('06_Bagre_v_f',t,k,s,m,p) + X_v.l('11_Nangodi_v_f',t,k,s,m,p) + X_v.l('Asibi_h_f',t,k,s,m,p) - X_v.l('12_Pwalugu_v_f',t,k,s,m,p)-X_v.l('BagrUr_d_f',t,k,s,m,p)
                                  -X_v.l('BagreAg_d_f',t,k,s,m,p)+X_v.l('BagreAg_r_f',t,k,s,m,p)+ X_v.l('BagrUr_r_f',t,k,s,m,p)- X_v.l('VeaAg_d_f',t,k,s,m,p)- X_v.l('TYaruAg_d_f',t,k,s,m,p)
                                  -X_v.l('TonoAg_d_f',t,k,s,m,p)- X_v.l('BolgaUr_d_f',t,k,s,m,p)  + X_v.l('TonoAg_r_f',t,k,s,m,p)+ X_v.l('BolgaUr_r_f',t,k,s,m,p)  + X_v.l('TONO_rel_f',t,k,s,m,p)
                                  +X_v.l('VeaAg_r_f',t,k,s,m,p)+X_v.l('TYaruAg_r_f',t,k,s,m,p)+ X_v.l('PWALU_rel_f',t,k,s,m,p)-sum((j),hectares_j_v.l('GoogAg_u_f',j,t,k,s,m,p)* Bu_p('GoogAg_u_f',j,k))+ eps;
*----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('TYaruAg_u_f',t,k,s,m,p) = X_v.l('06_Bagre_v_f',t,k,s,m,p) + X_v.l('11_Nangodi_v_f',t,k,s,m,p)+ X_v.l('Asibi_h_f',t,k,s,m,p)- X_v.l('12_Pwalugu_v_f',t,k,s,m,p)-X_v.l('BagrUr_d_f',t,k,s,m,p)
                                    +X_v.l('GoogAg_r_f',t,k,s,m,p)-X_v.l('BagreAg_d_f',t,k,s,m,p)+X_v.l('BagreAg_r_f',t,k,s,m,p)+ X_v.l('BagrUr_r_f',t,k,s,m,p)- X_v.l('GoogAg_d_f',t,k,s,m,p)-
                                     X_v.l('VeaAg_d_f',t,k,s,m,p)-X_v.l('TonoAg_d_f',t,k,s,m,p)+X_v.l('VeaAg_r_f',t,k,s,m,p)- X_v.l('BolgaUr_d_f',t,k,s,m,p)  + X_v.l('TonoAg_r_f',t,k,s,m,p)+
                                     X_v.l('BolgaUr_r_f',t,k,s,m,p)+ X_v.l('TONO_rel_f',t,k,s,m,p)+ X_v.l('PWALU_rel_f',t,k,s,m,p)- sum((j),hectares_j_v.l('TYaruAg_u_f',j,t,k,s,m,p)* Bu_p('TYaruAg_u_f',j,k)) + eps;
*----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('BolgaUr_u_f',t,k,s,m,p) = X_v.l('06_Bagre_v_f',t,k,s,m,p)+ X_v.l('11_Nangodi_v_f',t,k,s,m,p)+ X_v.l('Asibi_h_f',t,k,s,m,p)- X_v.l('12_Pwalugu_v_f',t,k,s,m,p)-X_v.l('BagrUr_d_f',t,k,s,m,p)
                                   -X_v.l('BagreAg_d_f',t,k,s,m,p)+X_v.l('BagreAg_r_f',t,k,s,m,p)+ X_v.l('BagrUr_r_f',t,k,s,m,p)- X_v.l('GoogAg_d_f',t,k,s,m,p)+X_v.l('GoogAg_r_f',t,k,s,m,p)
                                  - X_v.l('TYaruAg_d_f',t,k,s,m,p)+ X_v.l('TYaruAg_r_f',t,k,s,m,p)-X_v.l('VeaAg_d_f',t,k,s,m,p)- X_v.l('TonoAg_d_f',t,k,s,m,p)+ X_v.l('VeaAg_r_f',t,k,s,m,p)
                                  + X_v.l('TonoAg_r_f',t,k,s,m,p)+ X_v.l('TONO_rel_f',t,k,s,m,p)+ X_v.l('PWALU_rel_f',t,k,s,m,p)- X_v.l('BolgaUr_u_f',t,k,s,m,p) + eps;
*----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('PwaluAg_u_f',t,k,s,m,p)=X_v.l('Sisili_h_f',t,k,s,m,p)+X_v.l('Kulpn_h_f',t,k,s,m,p) +X_v.l('12_Pwalugu_v_f',t,k,s,m,p)+ X_v.l('Nasia_h_f',t,k,s,m,p)-X_v.l('13_Nawuni_v_f',t,k,s,m,p)
                                   - sum((j),hectares_j_v.l('PwaluAg_u_f',j,t,k,s,m,p)* Bu_p('PwaluAg_u_f',j,k)) + eps;
*----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('SubinjAg_u_f',t,k,s,m,p)= X_v.l('Subin_h_f',    t,k,s,m,p)+ X_v.l('Mole_h_f',       t,k,s,m,p)+ X_v.l('Mo_h_f',      t,k,s,m,p) + X_v.l('13_Nawuni_v_f',  t,k,s,m,p)+ X_v.l('14_Bamboi_v_f',t,k,s,m,p)
                                         + X_v.l('15_Sabari_v_f',t,k,s,m,p)+ X_v.l('16_Ekumdipe_v_f',t,k,s,m,p)+ X_v.l('17_Prang_v_f',t,k,s,m,p) - X_v.l('18_AkosomUp_v_f',t,k,s,m,p)- X_v.l('DipaliAg_d_f', t,k,s,m,p)
                                         - X_v.l('SogoAg_d_f',   t,k,s,m,p)- X_v.l('LibgaAg_d_f',    t,k,s,m,p)- X_v.l('SavelUr_d_f', t,k,s,m,p) - X_v.l('GolgaAg_d_f',    t,k,s,m,p)- X_v.l('BotangAg_d_f', t,k,s,m,p)
                                         - X_v.l('DaboAg_d_f',   t,k,s,m,p)- X_v.l('TamaleUr_d_f',   t,k,s,m,p)- X_v.l('YapeiAg_d_f', t,k,s,m,p) - X_v.l('NewLoAg_d_f',    t,k,s,m,p)- X_v.l('AsanKAg_d_f',  t,k,s,m,p)
                                         - X_v.l('BuipeAg_d_f',  t,k,s,m,p)- X_v.l('DambUr_d_f',     t,k,s,m,p)+ X_v.l('DipaliAg_r_f',t,k,s,m,p) + X_v.l('SogoAg_r_f',     t,k,s,m,p)+ X_v.l('LibgaAg_r_f',  t,k,s,m,p)
                                         + X_v.l('SavelUr_r_f',  t,k,s,m,p)+ X_v.l('GolgaAg_r_f',    t,k,s,m,p)+ X_v.l('BotangAg_r_f',t,k,s,m,p) + X_v.l('DaboAg_r_f',     t,k,s,m,p)+ X_v.l('TamaleUr_r_f', t,k,s,m,p)
                                         + X_v.l('YapeiAg_r_f',  t,k,s,m,p)+ X_v.l('NewLoAg_r_f',    t,k,s,m,p)+ X_v.l('AsanKAg_r_f', t,k,s,m,p) + X_v.l('BuipeAg_r_f',    t,k,s,m,p)+ X_v.l('DambUr_r_f',   t,k,s,m,p)
                                         + X_v.l('AMATE_rel_f',  t,k,s,m,p)+ X_v.l('SUBIN_rel_f',    t,k,s,m,p)-sum((j),hectares_j_v.l('SubinjAg_u_f',j,t,k,s,m,p)* Bu_p('SubinjAg_u_f',j,k)) + eps;
*----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('DipaliAg_u_f',t,k,s,m,p)= X_v.l('Subin_h_f',    t,k,s,m,p)+ X_v.l('Mole_h_f',       t,k,s,m,p)+ X_v.l('Mo_h_f',      t,k,s,m,p)+ X_v.l('13_Nawuni_v_f',   t,k,s,m,p)+ X_v.l('14_Bamboi_v_f',t,k,s,m,p)
                                         + X_v.l('15_Sabari_v_f',t,k,s,m,p)+ X_v.l('16_Ekumdipe_v_f',t,k,s,m,p)+ X_v.l('17_Prang_v_f',t,k,s,m,p)- X_v.l('18_AkosomUp_v_f', t,k,s,m,p)- X_v.l('SubinjAg_d_f', t,k,s,m,p)
                                         - X_v.l('SogoAg_d_f',   t,k,s,m,p)- X_v.l('LibgaAg_d_f',    t,k,s,m,p)- X_v.l('SavelUr_d_f', t,k,s,m,p)- X_v.l('GolgaAg_d_f',     t,k,s,m,p)- X_v.l('BotangAg_d_f', t,k,s,m,p)
                                         - X_v.l('DaboAg_d_f',   t,k,s,m,p)- X_v.l('TamaleUr_d_f',   t,k,s,m,p)- X_v.l('YapeiAg_d_f', t,k,s,m,p)- X_v.l('NewLoAg_d_f',     t,k,s,m,p)- X_v.l('AsanKAg_d_f',  t,k,s,m,p)
                                         - X_v.l('BuipeAg_d_f',  t,k,s,m,p)- X_v.l('DambUr_d_f',     t,k,s,m,p)+ X_v.l('SubinjAg_r_f',t,k,s,m,p)+ X_v.l('SogoAg_r_f',      t,k,s,m,p)+ X_v.l('LibgaAg_r_f',  t,k,s,m,p)
                                         + X_v.l('SavelUr_r_f',  t,k,s,m,p)+ X_v.l('GolgaAg_r_f',    t,k,s,m,p)+ X_v.l('BotangAg_r_f',t,k,s,m,p)+ X_v.l('DaboAg_r_f',      t,k,s,m,p)+ X_v.l('TamaleUr_r_f', t,k,s,m,p)
                                         + X_v.l('YapeiAg_r_f',  t,k,s,m,p)+ X_v.l('NewLoAg_r_f',    t,k,s,m,p)+ X_v.l('AsanKAg_r_f', t,k,s,m,p)+ X_v.l('BuipeAg_r_f',     t,k,s,m,p)+ X_v.l('DambUr_r_f',   t,k,s,m,p)
                                         + X_v.l('AMATE_rel_f',  t,k,s,m,p)+ X_v.l('SUBIN_rel_f',    t,k,s,m,p)- sum((j),hectares_j_v.l('DipaliAg_u_f',j,t,k,s,m,p)* Bu_p('DipaliAg_u_f',j,k)) + eps;
*----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('SogoAg_u_f',  t,k,s,m,p)= X_v.l('Subin_h_f',    t,k,s,m,p)+ X_v.l('Mole_h_f',       t,k,s,m,p)+ X_v.l('Mo_h_f',      t,k,s,m,p)+ X_v.l('13_Nawuni_v_f',   t,k,s,m,p)+ X_v.l('14_Bamboi_v_f',t,k,s,m,p)
                                         + X_v.l('15_Sabari_v_f',t,k,s,m,p)+ X_v.l('16_Ekumdipe_v_f',t,k,s,m,p)+ X_v.l('17_Prang_v_f',t,k,s,m,p)- X_v.l('18_AkosomUp_v_f', t,k,s,m,p)- X_v.l('DipaliAg_d_f', t,k,s,m,p)
                                         - X_v.l('LibgaAg_d_f',  t,k,s,m,p)- X_v.l('SavelUr_d_f',    t,k,s,m,p)- X_v.l('GolgaAg_d_f', t,k,s,m,p)- X_v.l('BotangAg_d_f',    t,k,s,m,p)- X_v.l('DaboAg_d_f',   t,k,s,m,p)
                                         - X_v.l('TamaleUr_d_f', t,k,s,m,p)- X_v.l('YapeiAg_d_f',    t,k,s,m,p)- X_v.l('NewLoAg_d_f', t,k,s,m,p)- X_v.l('AsanKAg_d_f',     t,k,s,m,p)- X_v.l('BuipeAg_d_f',  t,k,s,m,p)
                                         - X_v.l('DambUr_d_f',   t,k,s,m,p)+ X_v.l('DipaliAg_r_f',   t,k,s,m,p)+ X_v.l('LibgaAg_r_f', t,k,s,m,p)+ X_v.l('SavelUr_r_f',     t,k,s,m,p)+ X_v.l('GolgaAg_r_f',  t,k,s,m,p)
                                         + X_v.l('BotangAg_r_f', t,k,s,m,p)+ X_v.l('DaboAg_r_f',     t,k,s,m,p)+ X_v.l('TamaleUr_r_f',t,k,s,m,p)+ X_v.l('YapeiAg_r_f',     t,k,s,m,p)+X_v.l('NewLoAg_r_f',   t,k,s,m,p)
                                         + X_v.l('AsanKAg_r_f',  t,k,s,m,p)+ X_v.l('BuipeAg_r_f',    t,k,s,m,p)+ X_v.l('DambUr_r_f',  t,k,s,m,p)+ X_v.l('AMATE_rel_f',     t,k,s,m,p)+ X_v.l('SUBIN_rel_f',  t,k,s,m,p)
                                         - X_v.l('SubinjAg_d_f', t,k,s,m,p)+ X_v.l('SubinjAg_r_f',   t,k,s,m,p)- sum((j),hectares_j_v.l('SogoAg_u_f',j,t,k,s,m,p)* Bu_p('SogoAg_u_f',j,k))  + eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('LibgaAg_u_f',t,k,s,m,p) = X_v.l('Subin_h_f',    t,k,s,m,p)+ X_v.l('Mole_h_f',       t,k,s,m,p)+ X_v.l('Mo_h_f',      t,k,s,m,p)+ X_v.l('13_Nawuni_v_f',   t,k,s,m,p)+ X_v.l('14_Bamboi_v_f',t,k,s,m,p)
                                         + X_v.l('15_Sabari_v_f',t,k,s,m,p)+ X_v.l('16_Ekumdipe_v_f',t,k,s,m,p)+ X_v.l('17_Prang_v_f',t,k,s,m,p)- X_v.l('18_AkosomUp_v_f', t,k,s,m,p)- X_v.l('DipaliAg_d_f', t,k,s,m,p)
                                         - X_v.l('SogoAg_d_f',   t,k,s,m,p)- X_v.l('SavelUr_d_f',    t,k,s,m,p)- X_v.l('GolgaAg_d_f', t,k,s,m,p)- X_v.l('BotangAg_d_f',    t,k,s,m,p)- X_v.l('DaboAg_d_f',   t,k,s,m,p)
                                         - X_v.l('TamaleUr_d_f', t,k,s,m,p)- X_v.l('YapeiAg_d_f',    t,k,s,m,p)- X_v.l('NewLoAg_d_f', t,k,s,m,p)- X_v.l('AsanKAg_d_f',     t,k,s,m,p)- X_v.l('BuipeAg_d_f',  t,k,s,m,p)
                                         - X_v.l('DambUr_d_f',   t,k,s,m,p)+ X_v.l('DipaliAg_r_f',   t,k,s,m,p)+ X_v.l('SogoAg_r_f',  t,k,s,m,p)+ X_v.l('SavelUr_r_f',     t,k,s,m,p)+ X_v.l('GolgaAg_r_f',  t,k,s,m,p)
                                         + X_v.l('BotangAg_r_f', t,k,s,m,p)+ X_v.l('DaboAg_r_f',     t,k,s,m,p)+ X_v.l('TamaleUr_r_f',t,k,s,m,p)+ X_v.l('YapeiAg_r_f',     t,k,s,m,p)+ X_v.l('NewLoAg_r_f',  t,k,s,m,p)
                                         + X_v.l('AsanKAg_r_f',  t,k,s,m,p)+ X_v.l('BuipeAg_r_f',    t,k,s,m,p)+ X_v.l('DambUr_r_f',  t,k,s,m,p)+ X_v.l('AMATE_rel_f',     t,k,s,m,p)+ X_v.l('SUBIN_rel_f',  t,k,s,m,p)
                                         - X_v.l('SubinjAg_d_f', t,k,s,m,p)+ X_v.l('SubinjAg_r_f',   t,k,s,m,p)- sum((j),hectares_j_v.l('LibgaAg_u_f',j,t,k,s,m,p)* Bu_p('LibgaAg_u_f',j,k)) + eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('SavelUr_u_f',t,k,s,m,p) = X_v.l('Subin_h_f',    t,k,s,m,p)+ X_v.l('13_Nawuni_v_f',  t,k,s,m,p)+ X_v.l('14_Bamboi_v_f',t,k,s,m,p)+ X_v.l('15_Sabari_v_f',  t,k,s,m,p)+ X_v.l('16_Ekumdipe_v_f',t,k,s,m,p)
                                         + X_v.l('Mole_h_f',     t,k,s,m,p)+ X_v.l('DipaliAg_r_f',   t,k,s,m,p)+ X_v.l('SogoAg_r_f',   t,k,s,m,p)+ X_v.l('LibgaAg_r_f',    t,k,s,m,p)+ X_v.l('DaboAg_r_f',     t,k,s,m,p)
                                         + X_v.l('BuipeAg_r_f',  t,k,s,m,p)+ X_v.l('YapeiAg_r_f',    t,k,s,m,p)+ X_v.l('DambUr_r_f',   t,k,s,m,p)- X_v.l('DipaliAg_d_f',   t,k,s,m,p)- X_v.l('SogoAg_d_f',     t,k,s,m,p)
                                         - X_v.l('LibgaAg_d_f',  t,k,s,m,p)- X_v.l('DaboAg_d_f',     t,k,s,m,p)- X_v.l('YapeiAg_d_f',  t,k,s,m,p)- X_v.l('DambUr_d_f',     t,k,s,m,p)+ X_v.l('NewLoAg_r_f',    t,k,s,m,p)
                                         + X_v.l('AsanKAg_r_f',  t,k,s,m,p)- X_v.l('NewLoAg_d_f',    t,k,s,m,p)- X_v.l('AsanKAg_d_f',  t,k,s,m,p)+ X_v.l('17_Prang_v_f',   t,k,s,m,p)- X_v.l('18_AkosomUp_v_f',t,k,s,m,p)
                                         + X_v.l('Mo_h_f',       t,k,s,m,p)- X_v.l('GolgaAg_d_f',    t,k,s,m,p)- X_v.l('BotangAg_d_f', t,k,s,m,p)- X_v.l('TamaleUr_d_f',   t,k,s,m,p)+ X_v.l('GolgaAg_r_f',    t,k,s,m,p)
                                         - X_v.l('SubinjAg_d_f', t,k,s,m,p)+ X_v.l('SubinjAg_r_f',   t,k,s,m,p)- X_v.l('BuipeAg_d_f',  t,k,s,m,p)+ X_v.l('BotangAg_r_f',   t,k,s,m,p)+ X_v.l('TamaleUr_r_f',   t,k,s,m,p)
                                         + X_v.l('AMATE_rel_f',  t,k,s,m,p)+ X_v.l('SUBIN_rel_f',    t,k,s,m,p)- X_v.l('SavelUr_u_f',  t,k,s,m,p) + eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('GolgaAg_u_f',t,k,s,m,p) = X_v.l('Subin_h_f',    t,k,s,m,p)+ X_v.l('13_Nawuni_v_f',  t,k,s,m,p)+ X_v.l('14_Bamboi_v_f',t,k,s,m,p) + X_v.l('15_Sabari_v_f', t,k,s,m,p)+ X_v.l('16_Ekumdipe_v_f',t,k,s,m,p)
                                         + X_v.l('DipaliAg_r_f', t,k,s,m,p)+ X_v.l('SogoAg_r_f',     t,k,s,m,p)+ X_v.l('SavelUr_r_f',  t,k,s,m,p) + X_v.l('DaboAg_r_f',    t,k,s,m,p)+ X_v.l('YapeiAg_r_f',    t,k,s,m,p)
                                         + X_v.l('Mole_h_f',     t,k,s,m,p)+ X_v.l('DambUr_r_f',     t,k,s,m,p)- X_v.l('DipaliAg_d_f', t,k,s,m,p) - X_v.l('SogoAg_d_f',    t,k,s,m,p)- X_v.l('SavelUr_d_f',    t,k,s,m,p)
                                         - X_v.l('YapeiAg_d_f',  t,k,s,m,p)- X_v.l('DambUr_d_f',     t,k,s,m,p)+ X_v.l('NewLoAg_r_f',  t,k,s,m,p) + X_v.l('AsanKAg_r_f',   t,k,s,m,p)- X_v.l('NewLoAg_d_f',    t,k,s,m,p)
                                         - X_v.l('AsanKAg_d_f',  t,k,s,m,p)+ X_v.l('17_Prang_v_f',   t,k,s,m,p)- X_v.l('LibgaAg_d_f', t,k,s,m,p) + X_v.l('BuipeAg_r_f',   t,k,s,m,p)- X_v.l('DaboAg_d_f',     t,k,s,m,p)
                                         - X_v.l('BotangAg_d_f', t,k,s,m,p)- X_v.l('TamaleUr_d_f',   t,k,s,m,p)+ X_v.l('LibgaAg_r_f',  t,k,s,m,p) + X_v.l('BotangAg_r_f',  t,k,s,m,p)- X_v.l('BuipeAg_d_f',    t,k,s,m,p)
                                         - X_v.l('SubinjAg_d_f', t,k,s,m,p)+ X_v.l('SubinjAg_r_f',   t,k,s,m,p)+ X_v.l('TamaleUr_r_f', t,k,s,m,p) + X_v.l('AMATE_rel_f',   t,k,s,m,p)+ X_v.l('SUBIN_rel_f',    t,k,s,m,p)
                                         - X_v.l('18_AkosomUp_v_f',t,k,s,m,p)- sum((j),hectares_j_v.l('GolgaAg_u_f',j,t,k,s,m,p)* Bu_p('GolgaAg_u_f',j,k))+ X_v.l('Mo_h_f',t,k,s,m,p)+ eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('BotangAg_u_f',t,k,s,m,p)= X_v.l('Subin_h_f',    t,k,s,m,p)+ X_v.l('13_Nawuni_v_f',t,k,s,m,p) + X_v.l('14_Bamboi_v_f',t,k,s,m,p) + X_v.l('15_Sabari_v_f', t,k,s,m,p)+ X_v.l('16_Ekumdipe_v_f',t,k,s,m,p)
                                         + X_v.l('Mole_h_f',     t,k,s,m,p)+ X_v.l('DipaliAg_r_f', t,k,s,m,p) + X_v.l('SogoAg_r_f',   t,k,s,m,p) + X_v.l('SavelUr_r_f',   t,k,s,m,p)+ X_v.l('DaboAg_r_f',     t,k,s,m,p)
                                         + X_v.l('DambUr_r_f',   t,k,s,m,p)- X_v.l('DipaliAg_d_f', t,k,s,m,p) - X_v.l('SogoAg_d_f',   t,k,s,m,p) - X_v.l('SavelUr_d_f',   t,k,s,m,p)- X_v.l('DaboAg_d_f',     t,k,s,m,p)
                                         - X_v.l('YapeiAg_d_f',  t,k,s,m,p)- X_v.l('DambUr_d_f',   t,k,s,m,p) + X_v.l('NewLoAg_r_f',  t,k,s,m,p) + X_v.l('AsanKAg_r_f',   t,k,s,m,p)- X_v.l('NewLoAg_d_f',    t,k,s,m,p)
                                         - X_v.l('AsanKAg_d_f',  t,k,s,m,p)+ X_v.l('17_Prang_v_f', t,k,s,m,p) - X_v.l('GolgaAg_d_f',  t,k,s,m,p) + X_v.l('BuipeAg_r_f',   t,k,s,m,p)- X_v.l('LibgaAg_d_f',    t,k,s,m,p)
                                         - X_v.l('TamaleUr_d_f', t,k,s,m,p)+ X_v.l('GolgaAg_r_f',  t,k,s,m,p) + X_v.l('LibgaAg_r_f',  t,k,s,m,p) - X_v.l('BuipeAg_d_f',   t,k,s,m,p)+ X_v.l('YapeiAg_r_f',    t,k,s,m,p)
                                         + X_v.l('TamaleUr_r_f', t,k,s,m,p)- X_v.l('SubinjAg_d_f', t,k,s,m,p) + X_v.l('SubinjAg_r_f',   t,k,s,m,p)+ X_v.l('AMATE_rel_f',  t,k,s,m,p)+ X_v.l('SUBIN_rel_f',    t,k,s,m,p)
                                         - X_v.l('18_AkosomUp_v_f',t,k,s,m,p) - sum((j),hectares_j_v.l('BotangAg_u_f',j,t,k,s,m,p)* Bu_p('BotangAg_u_f',j,k))+ X_v.l('Mo_h_f',t,k,s,m,p) + eps;
*----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('DaboAg_u_f',t,k,s,m,p)  = X_v.l('Subin_h_f',    t,k,s,m,p)+ X_v.l('13_Nawuni_v_f',t,k,s,m,p) + X_v.l('14_Bamboi_v_f',t,k,s,m,p) + X_v.l('15_Sabari_v_f',t,k,s,m,p) + X_v.l('16_Ekumdipe_v_f',t,k,s,m,p)
                                         + X_v.l('DipaliAg_r_f', t,k,s,m,p)+ X_v.l('SogoAg_r_f',   t,k,s,m,p) + X_v.l('SavelUr_r_f',  t,k,s,m,p) + X_v.l('BotangAg_r_f',   t,k,s,m,p)+ X_v.l('YapeiAg_r_f',   t,k,s,m,p)
                                         + X_v.l('DambUr_r_f',   t,k,s,m,p)- X_v.l('DipaliAg_d_f', t,k,s,m,p) - X_v.l('SogoAg_d_f',   t,k,s,m,p) - X_v.l('SavelUr_d_f',    t,k,s,m,p)- X_v.l('BotangAg_d_f',  t,k,s,m,p)
                                         - X_v.l('YapeiAg_d_f',  t,k,s,m,p)- X_v.l('DambUr_d_f',   t,k,s,m,p) + X_v.l('NewLoAg_r_f',  t,k,s,m,p) + X_v.l('AsanKAg_r_f',    t,k,s,m,p)- X_v.l('NewLoAg_d_f',   t,k,s,m,p)
                                         - X_v.l('AsanKAg_d_f',  t,k,s,m,p)+ X_v.l('17_Prang_v_f', t,k,s,m,p) - X_v.l('GolgaAg_d_f',  t,k,s,m,p) + X_v.l('BuipeAg_r_f',    t,k,s,m,p)+ X_v.l('Mole_h_f',      t,k,s,m,p)
                                         - X_v.l('SubinjAg_d_f', t,k,s,m,p)+ X_v.l('SubinjAg_r_f', t,k,s,m,p) - X_v.l('LibgaAg_d_f',  t,k,s,m,p) - X_v.l('TamaleUr_d_f',   t,k,s,m,p)+ X_v.l('GolgaAg_r_f',   t,k,s,m,p)
                                         + X_v.l('LibgaAg_r_f',  t,k,s,m,p)- X_v.l('BuipeAg_d_f',  t,k,s,m,p) + X_v.l('AMATE_rel_f',  t,k,s,m,p)+ X_v.l('SUBIN_rel_f',     t,k,s,m,p)+ X_v.l('TamaleUr_r_f',  t,k,s,m,p)
                                         - X_v.l('18_AkosomUp_v_f',t,k,s,m,p) - sum((j),hectares_j_v.l('DaboAg_u_f',j,t,k,s,m,p)* Bu_p('DaboAg_u_f',j,k))+ X_v.l('Mo_h_f',t,k,s,m,p) + eps;
*----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('TamaleUr_u_f',t,k,s,m,p)= X_v.l('Subin_h_f',    t,k,s,m,p)+ X_v.l('13_Nawuni_v_f',t,k,s,m,p) + X_v.l('14_Bamboi_v_f',t,k,s,m,p) + X_v.l('15_Sabari_v_f',  t,k,s,m,p)+ X_v.l('16_Ekumdipe_v_f',t,k,s,m,p)
                                         + X_v.l('DipaliAg_r_f', t,k,s,m,p)+ X_v.l('SogoAg_r_f',   t,k,s,m,p) + X_v.l('LibgaAg_r_f',  t,k,s,m,p) + X_v.l('DaboAg_r_f',     t,k,s,m,p)+ X_v.l('BuipeAg_r_f',    t,k,s,m,p)
                                         + X_v.l('YapeiAg_r_f',  t,k,s,m,p)+ X_v.l('DambUr_r_f',   t,k,s,m,p) - X_v.l('DipaliAg_d_f', t,k,s,m,p) - X_v.l('SogoAg_d_f',     t,k,s,m,p)- X_v.l('LibgaAg_d_f',    t,k,s,m,p)
                                         - X_v.l('DaboAg_d_f',   t,k,s,m,p)- X_v.l('YapeiAg_d_f',  t,k,s,m,p) - X_v.l('DambUr_d_f',   t,k,s,m,p) + X_v.l('NewLoAg_r_f',    t,k,s,m,p)+ X_v.l('AsanKAg_r_f',    t,k,s,m,p)
                                         - X_v.l('NewLoAg_d_f',  t,k,s,m,p)- X_v.l('AsanKAg_d_f',  t,k,s,m,p) + X_v.l('17_Prang_v_f', t,k,s,m,p) - X_v.l('18_AkosomUp_v_f',t,k,s,m,p)+ X_v.l('Mole_h_f',       t,k,s,m,p)
                                         - X_v.l('GolgaAg_d_f',  t,k,s,m,p)- X_v.l('BotangAg_d_f', t,k,s,m,p) - X_v.l('SavelUr_d_f',  t,k,s,m,p) + X_v.l('GolgaAg_r_f',    t,k,s,m,p)- X_v.l('SubinjAg_d_f',   t,k,s,m,p)
                                         - X_v.l('BuipeAg_d_f',  t,k,s,m,p)+ X_v.l('BotangAg_r_f', t,k,s,m,p) + X_v.l('SavelUr_r_f',  t,k,s,m,p)+ X_v.l('AMATE_rel_f',     t,k,s,m,p)+ X_v.l('SUBIN_rel_f',    t,k,s,m,p)
                                         + X_v.l('SubinjAg_r_f',t,k,s,m,p)+ X_v.l('Mo_h_f',       t,k,s,m,p) - X_v.l('TamaleUr_u_f', t,k,s,m,p) + eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('YapeiAg_u_f',t,k,s,m,p) = X_v.l('Subin_h_f',    t,k,s,m,p)+ X_v.l('13_Nawuni_v_f',t,k,s,m,p) + X_v.l('14_Bamboi_v_f',t,k,s,m,p)+ X_v.l('15_Sabari_v_f',t,k,s,m,p)+ X_v.l('16_Ekumdipe_v_f',t,k,s,m,p)
                                         + X_v.l('DipaliAg_r_f', t,k,s,m,p)+ X_v.l('SogoAg_r_f',   t,k,s,m,p) + X_v.l('SavelUr_r_f',  t,k,s,m,p)+ X_v.l('BotangAg_r_f', t,k,s,m,p)+ X_v.l('DaboAg_r_f',     t,k,s,m,p)
                                         + X_v.l('DambUr_r_f',   t,k,s,m,p)- X_v.l('DipaliAg_d_f', t,k,s,m,p) - X_v.l('SogoAg_d_f',   t,k,s,m,p)- X_v.l('SavelUr_d_f',  t,k,s,m,p)- X_v.l('BotangAg_d_f',   t,k,s,m,p)
                                         - X_v.l('DaboAg_d_f',   t,k,s,m,p)- X_v.l('DambUr_d_f',   t,k,s,m,p) + X_v.l('NewLoAg_r_f',  t,k,s,m,p)+ X_v.l('AsanKAg_r_f',  t,k,s,m,p)- X_v.l('NewLoAg_d_f',    t,k,s,m,p)
                                         - X_v.l('AsanKAg_d_f',  t,k,s,m,p)+ X_v.l('17_Prang_v_f', t,k,s,m,p) + X_v.l('Mo_h_f',       t,k,s,m,p)- X_v.l('GolgaAg_d_f',  t,k,s,m,p)+ X_v.l('BuipeAg_r_f',    t,k,s,m,p)
                                         - X_v.l('LibgaAg_d_f',  t,k,s,m,p)- X_v.l('TamaleUr_d_f', t,k,s,m,p) + X_v.l('GolgaAg_r_f',  t,k,s,m,p)+ X_v.l('LibgaAg_r_f',  t,k,s,m,p)- X_v.l('BuipeAg_d_f',    t,k,s,m,p)
                                         - X_v.l('SubinjAg_d_f', t,k,s,m,p)+ X_v.l('SubinjAg_r_f', t,k,s,m,p) + X_v.l('AMATE_rel_f',  t,k,s,m,p)+ X_v.l('SUBIN_rel_f',  t,k,s,m,p)+ X_v.l('TamaleUr_r_f',   t,k,s,m,p)
                                         - X_v.l('18_AkosomUp_v_f',t,k,s,m,p) - sum((j),hectares_j_v.l('YapeiAg_u_f',j,t,k,s,m,p)* Bu_p('YapeiAg_u_f',j,k))+ X_v.l('Mole_h_f',t,k,s,m,p) + eps;
*------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('NewLoAg_u_f',t,k,s,m,p) = X_v.l('Subin_h_f',    t,k,s,m,p)+ X_v.l('13_Nawuni_v_f',t,k,s,m,p) + X_v.l('14_Bamboi_v_f',t,k,s,m,p)+ X_v.l('15_Sabari_v_f',t,k,s,m,p)+ X_v.l('16_Ekumdipe_v_f',t,k,s,m,p)
                                         + X_v.l('DipaliAg_r_f', t,k,s,m,p)+ X_v.l('SogoAg_r_f',   t,k,s,m,p) + X_v.l('SavelUr_r_f',  t,k,s,m,p)+ X_v.l('BotangAg_r_f', t,k,s,m,p)- X_v.l('18_AkosomUp_v_f',t,k,s,m,p)
                                         + X_v.l('DambUr_r_f',   t,k,s,m,p)- X_v.l('DipaliAg_d_f', t,k,s,m,p) - X_v.l('SogoAg_d_f',   t,k,s,m,p)- X_v.l('SavelUr_d_f',  t,k,s,m,p)- X_v.l('BotangAg_d_f',   t,k,s,m,p)
                                         - X_v.l('DaboAg_d_f',   t,k,s,m,p)- X_v.l('DambUr_d_f',   t,k,s,m,p) + X_v.l('YapeiAg_r_f',  t,k,s,m,p)+ X_v.l('AsanKAg_r_f',  t,k,s,m,p)- X_v.l('YapeiAg_d_f',    t,k,s,m,p)
                                         - X_v.l('AsanKAg_d_f',  t,k,s,m,p)+ X_v.l('17_Prang_v_f', t,k,s,m,p) - X_v.l('GolgaAg_d_f',  t,k,s,m,p)+ X_v.l('BuipeAg_r_f',  t,k,s,m,p)+ X_v.l('DaboAg_r_f',     t,k,s,m,p)
                                         - X_v.l('LibgaAg_d_f',  t,k,s,m,p)- X_v.l('TamaleUr_d_f', t,k,s,m,p) + X_v.l('GolgaAg_r_f',  t,k,s,m,p)+ X_v.l('LibgaAg_r_f',  t,k,s,m,p)- X_v.l('BuipeAg_d_f',    t,k,s,m,p)
                                         - X_v.l('SubinjAg_d_f', t,k,s,m,p)+ X_v.l('SubinjAg_r_f', t,k,s,m,p) + X_v.l('AMATE_rel_f',  t,k,s,m,p)+ X_v.l('SUBIN_rel_f',  t,k,s,m,p)+ X_v.l('Mole_h_f',       t,k,s,m,p)
                                         + X_v.l('TamaleUr_r_f', t,k,s,m,p)- sum((j),hectares_j_v.l('NewLoAg_u_f',j,t,k,s,m,p)* Bu_p('NewLoAg_u_f',j,k)) + X_v.l('Mo_h_f',t,k,s,m,p)+ eps;
*------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('AsanKAg_u_f',t,k,s,m,p) = X_v.l('Subin_h_f',    t,k,s,m,p)+ X_v.l('13_Nawuni_v_f',t,k,s,m,p) + X_v.l('14_Bamboi_v_f',t,k,s,m,p)+ X_v.l('15_Sabari_v_f',t,k,s,m,p)+ X_v.l('16_Ekumdipe_v_f',t,k,s,m,p)
                                         + X_v.l('DipaliAg_r_f', t,k,s,m,p)+ X_v.l('SogoAg_r_f',   t,k,s,m,p) + X_v.l('SavelUr_r_f',  t,k,s,m,p)+ X_v.l('BotangAg_r_f', t,k,s,m,p)+ X_v.l('DaboAg_r_f',     t,k,s,m,p)
                                         + X_v.l('DambUr_r_f',   t,k,s,m,p)- X_v.l('DipaliAg_d_f', t,k,s,m,p) - X_v.l('SogoAg_d_f',   t,k,s,m,p)- X_v.l('SavelUr_d_f',  t,k,s,m,p)- X_v.l('BotangAg_d_f',   t,k,s,m,p)
                                         - X_v.l('DaboAg_d_f',   t,k,s,m,p)- X_v.l('DambUr_d_f',   t,k,s,m,p) + X_v.l('NewLoAg_r_f',  t,k,s,m,p)+ X_v.l('YapeiAg_r_f',  t,k,s,m,p)- X_v.l('NewLoAg_d_f',    t,k,s,m,p)
                                         - X_v.l('YapeiAg_d_f',  t,k,s,m,p)+ X_v.l('17_Prang_v_f', t,k,s,m,p) - X_v.l('GolgaAg_d_f',  t,k,s,m,p)+ X_v.l('BuipeAg_r_f',  t,k,s,m,p)- X_v.l('18_AkosomUp_v_f',t,k,s,m,p)
                                         - X_v.l('LibgaAg_d_f',  t,k,s,m,p)- X_v.l('TamaleUr_d_f', t,k,s,m,p) + X_v.l('GolgaAg_r_f',  t,k,s,m,p)  + X_v.l('LibgaAg_r_f',t,k,s,m,p)- X_v.l('BuipeAg_d_f',    t,k,s,m,p)
                                         - X_v.l('SubinjAg_d_f', t,k,s,m,p)+ X_v.l('SubinjAg_r_f', t,k,s,m,p) + X_v.l('AMATE_rel_f',  t,k,s,m,p)+ X_v.l('SUBIN_rel_f',  t,k,s,m,p)+ X_v.l('Mole_h_f',       t,k,s,m,p)
                                         + X_v.l('TamaleUr_r_f', t,k,s,m,p)- sum((j),hectares_j_v.l('AsanKAg_u_f',j,t,k,s,m,p)* Bu_p('AsanKAg_u_f',j,k))+ X_v.l('Mo_h_f',t,k,s,m,p) + eps;
*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('BuipeAg_u_f',t,k,s,m,p) = X_v.l('Subin_h_f',   t,k,s,m,p)+  X_v.l('13_Nawuni_v_f',t,k,s,m,p) + X_v.l('14_Bamboi_v_f',t,k,s,m,p)+ X_v.l('15_Sabari_v_f',t,k,s,m,p)+ X_v.l('16_Ekumdipe_v_f',t,k,s,m,p)
                                         + X_v.l('DipaliAg_r_f',t,k,s,m,p)+ X_v.l('SogoAg_r_f',    t,k,s,m,p) + X_v.l('SavelUr_r_f',  t,k,s,m,p)+ X_v.l('BotangAg_r_f', t,k,s,m,p)+ X_v.l('YapeiAg_r_f',    t,k,s,m,p)
                                         + X_v.l('DambUr_r_f',  t,k,s,m,p)- X_v.l('DipaliAg_d_f',  t,k,s,m,p) - X_v.l('SogoAg_d_f',   t,k,s,m,p)- X_v.l('SavelUr_d_f',  t,k,s,m,p)- X_v.l('BotangAg_d_f',   t,k,s,m,p)
                                         - X_v.l('YapeiAg_d_f', t,k,s,m,p)- X_v.l('DambUr_d_f',    t,k,s,m,p) + X_v.l('NewLoAg_r_f',  t,k,s,m,p)+ X_v.l('AsanKAg_r_f',  t,k,s,m,p)- X_v.l('NewLoAg_d_f',    t,k,s,m,p)
                                         - X_v.l('AsanKAg_d_f', t,k,s,m,p)+ X_v.l('17_Prang_v_f',  t,k,s,m,p) - X_v.l('GolgaAg_d_f',  t,k,s,m,p)+ X_v.l('DaboAg_r_f',   t,k,s,m,p)- X_v.l('18_AkosomUp_v_f',t,k,s,m,p)
                                         - X_v.l('LibgaAg_d_f', t,k,s,m,p)- X_v.l('TamaleUr_d_f',  t,k,s,m,p) + X_v.l('GolgaAg_r_f',t,k,s,m,p)  + X_v.l('LibgaAg_r_f',  t,k,s,m,p)- X_v.l('DaboAg_d_f',     t,k,s,m,p)
                                         + X_v.l('Mole_h_f',    t,k,s,m,p)- X_v.l('SubinjAg_d_f',  t,k,s,m,p) + X_v.l('SubinjAg_r_f', t,k,s,m,p)+ X_v.l('AMATE_rel_f',  t,k,s,m,p)+ X_v.l('SUBIN_rel_f',  t,k,s,m,p)
                                         + X_v.l('Mo_h_f',t,k,s,m,p) + X_v.l('TamaleUr_r_f',t,k,s,m,p)- sum((j),hectares_j_v.l('BuipeAg_u_f',j,t,k,s,m,p)* Bu_p('BuipeAg_u_f',j,k)) + eps;
*----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('DambUr_u_f',t,k,s,m,p)  = X_v.l('Subin_h_f',   t,k,s,m,p)+ X_v.l('13_Nawuni_v_f',t,k,s,m,p)+ X_v.l('14_Bamboi_v_f',t,k,s,m,p)+ X_v.l('15_Sabari_v_f',t,k,s,m,p)+ X_v.l('16_Ekumdipe_v_f',t,k,s,m,p)
                                         + X_v.l('DipaliAg_r_f',t,k,s,m,p)+ X_v.l('SogoAg_r_f',   t,k,s,m,p)+ X_v.l('LibgaAg_r_f',  t,k,s,m,p)+ X_v.l('DaboAg_r_f',   t,k,s,m,p)+ X_v.l('BuipeAg_r_f',    t,k,s,m,p)
                                         + X_v.l('YapeiAg_r_f', t,k,s,m,p)+ X_v.l('TamaleUr_r_f', t,k,s,m,p)- X_v.l('DipaliAg_d_f', t,k,s,m,p)- X_v.l('SogoAg_d_f',   t,k,s,m,p)- X_v.l('LibgaAg_d_f',    t,k,s,m,p)
                                         - X_v.l('DaboAg_d_f',  t,k,s,m,p)- X_v.l('YapeiAg_d_f',  t,k,s,m,p)- X_v.l('TamaleUr_d_f', t,k,s,m,p)+ X_v.l('NewLoAg_r_f',  t,k,s,m,p)+ X_v.l('AsanKAg_r_f',    t,k,s,m,p)
                                         - X_v.l('NewLoAg_d_f', t,k,s,m,p)- X_v.l('AsanKAg_d_f',  t,k,s,m,p)+ X_v.l('17_Prang_v_f', t,k,s,m,p)+ X_v.l('Mo_h_f',       t,k,s,m,p)- X_v.l('18_AkosomUp_v_f',t,k,s,m,p)
                                         - X_v.l('GolgaAg_d_f', t,k,s,m,p)- X_v.l('BotangAg_d_f', t,k,s,m,p)- X_v.l('SavelUr_d_f',  t,k,s,m,p)+ X_v.l('GolgaAg_r_f',  t,k,s,m,p)
                                         + X_v.l('Mole_h_f',    t,k,s,m,p)- X_v.l('SubinjAg_d_f', t,k,s,m,p)+ X_v.l('SubinjAg_r_f', t,k,s,m,p)+ X_v.l('AMATE_rel_f',  t,k,s,m,p)+ X_v.l('SUBIN_rel_f',  t,k,s,m,p)
                                         - X_v.l('BuipeAg_d_f', t,k,s,m,p)+ X_v.l('BotangAg_r_f', t,k,s,m,p)+ X_v.l('SavelUr_r_f',  t,k,s,m,p)- X_v.l('DambUr_u_f',t,k,s,m,p) + eps;
*----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('YendiUr_u_f',t,k,s,m,p) = X_v.l('Daka_h_f',t,k,s,m,p)- X_v.l('16_Ekumdipe_v_f',t,k,s,m,p) -X_v.l('YendiUr_u_f',t,k,s,m,p)+ eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('SabariAg_u_f',t,k,s,m,p)  =    X_v.l('09_Mango_v_f',t,k,s,m,p)+ X_v.l('10_Kouma_v_f',t,k,s,m,p)+ X_v.l('Kara_h_f',t,k,s,m,p)- X_v.l('15_Sabari_v_f',t,k,s,m,p)
                                           - sum((j),hectares_j_v.l('SabariAg_u_f',j,t,k,s,m,p)* Bu_p('SabariAg_u_f',j,k)) + eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('TanosoAg_u_f',t,k,s,m,p)  =     X_v.l('Pru_h_f',t,k,s,m,p)      - X_v.l('17_Prang_v_f',t,k,s,m,p)    - X_v.l('AkumaAg_d_f',t,k,s,m,p)
                                           + X_v.l('AkumaAg_r_f',t,k,s,m,p)  + X_v.l('TANOSO_rel_f',t,k,s,m,p)
                                           - sum((j),hectares_j_v.l('TanosoAg_u_f',j,t,k,s,m,p)* Bu_p('TanosoAg_u_f',j,k)) + eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('AkumaAg_u_f',t,k,s,m,p)  =          X_v.l('Pru_h_f',t,k,s,m,p)      - X_v.l('17_Prang_v_f',t,k,s,m,p)    - X_v.l('TanosoAg_d_f',t,k,s,m,p)
                                           + X_v.l('TanosoAg_r_f',t,k,s,m,p) + X_v.l('TANOSO_rel_f',t,k,s,m,p)
                                           - sum((j),hectares_j_v.l('AkumaAg_u_f',j,t,k,s,m,p)*Bu_p('AkumaAg_u_f',j,k)) + eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('AmateAg_u_f',t,k,s,m,p)  = X_v.l('Afram_h_f',   t,k,s,m,p)+ X_v.l('Tod_h_f',   t,k,s,m,p) + X_v.l('18_AkosomUp_v_f',t,k,s,m,p)- X_v.l('19_Senchi_v_f',t,k,s,m,p)
                                          - X_v.l('DedesoAg_d_f',t,k,s,m,p)- X_v.l('SataAg_d_f',t,k,s,m,p) - X_v.l('KpandoAg_d_f',t,k,s,m,p)+ X_v.l('DedesoAg_r_f',t,k,s,m,p)
                                          + X_v.l('SataAg_r_f',t,k,s,m,p) + X_v.l('KpandoAg_r_f',t,k,s,m,p)+ X_v.l('LVOLTA_rel_f',t,k,s,m,p)
                                          - sum((j),hectares_j_v.l('AmateAg_u_f',j,t,k,s,m,p)* Bu_p('AmateAg_u_f',j,k)) + eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('DedesoAg_u_f',t,k,s,m,p) = X_v.l('Afram_h_f',   t,k,s,m,p)+ X_v.l('Tod_h_f',   t,k,s,m,p)+ X_v.l('18_AkosomUp_v_f',t,k,s,m,p) - X_v.l('19_Senchi_v_f',t,k,s,m,p)
                                          - X_v.l('AmateAg_d_f', t,k,s,m,p)- X_v.l('SataAg_d_f',t,k,s,m,p)- X_v.l('KpandoAg_d_f',   t,k,s,m,p) + X_v.l('AmateAg_r_f',  t,k,s,m,p)
                                          + X_v.l('SataAg_r_f',t,k,s,m,p)   + X_v.l('KpandoAg_r_f',t,k,s,m,p)     + X_v.l('LVOLTA_rel_f',t,k,s,m,p)
                                          - sum((j),hectares_j_v.l('DedesoAg_u_f',j,t,k,s,m,p)* Bu_p('DedesoAg_u_f',j,k)) + eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('SataAg_u_f',t,k,s,m,p)   = X_v.l('Afram_h_f',   t,k,s,m,p)+ X_v.l('Tod_h_f',   t,k,s,m,p) +   X_v.l('18_AkosomUp_v_f',t,k,s,m,p) - X_v.l('19_Senchi_v_f',t,k,s,m,p)
                                          - X_v.l('AmateAg_d_f', t,k,s,m,p)- X_v.l('DedesoAg_d_f',t,k,s,m,p)  - X_v.l('KpandoAg_d_f',t,k,s,m,p)+ X_v.l('AmateAg_r_f',  t,k,s,m,p)
                                          + X_v.l('DedesoAg_r_f',t,k,s,m,p) + X_v.l('KpandoAg_r_f',t,k,s,m,p) + X_v.l('LVOLTA_rel_f',t,k,s,m,p)
                                          - sum((j),hectares_j_v.l('SataAg_u_f',j,t,k,s,m,p)* Bu_p('SataAg_u_f',j,k)) + eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('KpandoAg_u_f',t,k,s,m,p) = X_v.l('Afram_h_f',   t,k,s,m,p)+ X_v.l('Tod_h_f',   t,k,s,m,p)+ X_v.l('18_AkosomUp_v_f',t,k,s,m,p) - X_v.l('19_Senchi_v_f',t,k,s,m,p)
                                          - X_v.l('AmateAg_d_f', t,k,s,m,p)- X_v.l('DedesoAg_d_f',t,k,s,m,p)- X_v.l('SataAg_d_f',t,k,s,m,p)+ X_v.l('AmateAg_r_f',  t,k,s,m,p)
                                          + X_v.l('DedesoAg_r_f',t,k,s,m,p)   + X_v.l('SataAg_r_f',t,k,s,m,p)  + X_v.l('LVOLTA_rel_f',t,k,s,m,p)
                                          - sum((j),hectares_j_v.l('KpandoAg_u_f',j,t,k,s,m,p)* Bu_p('KpandoAg_u_f',j,k)) + eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('KpongAg_u_f',t,k,s,m,p) = X_v.l('19_Senchi_v_f',t,k,s,m,p) - X_v.l('20_Kpong_v_f',t,k,s,m,p)  - X_v.l('AveyimAg_d_f',t,k,s,m,p)
                                           - X_v.l('AccraUr_d_f',t,k,s,m,p)  - X_v.l('AfifeAg_d_f',t,k,s,m,p)  + X_v.l('AveyimAg_r_f',t,k,s,m,p)
                                           + X_v.l('AccraUr_r_f',t,k,s,m,p)  + X_v.l('AfifeAg_r_f',t,k,s,m,p)  + X_v.l('KPONG_rel_f',t,k,s,m,p)
                                           - sum((j),hectares_j_v.l('KpongAg_u_f',j,t,k,s,m,p)* Bu_p('KpongAg_u_f',j,k)) + eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('AveyimAg_u_f',t,k,s,m,p) =        X_v.l('19_Senchi_v_f',t,k,s,m,p)- X_v.l('20_Kpong_v_f',t,k,s,m,p)  - X_v.l('KpongAg_d_f',t,k,s,m,p)
                                           - X_v.l('AccraUr_d_f',t,k,s,m,p)  - X_v.l('AfifeAg_d_f',t,k,s,m,p)  + X_v.l('KpongAg_r_f',t,k,s,m,p)
                                           + X_v.l('AccraUr_r_f',t,k,s,m,p)  + X_v.l('AfifeAg_r_f',t,k,s,m,p)  + X_v.l('KPONG_rel_f',t,k,s,m,p)
                                           - sum((j),hectares_j_v.l('AveyimAg_u_f',j,t,k,s,m,p)* Bu_p('AveyimAg_u_f',j,k)) + eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('AccraUr_u_f',t,k,s,m,p)  =        X_v.l('19_Senchi_v_f',t,k,s,m,p) - X_v.l('20_Kpong_v_f',t,k,s,m,p)  - X_v.l('AveyimAg_d_f',t,k,s,m,p)
                                           - X_v.l('KpongAg_d_f',t,k,s,m,p)  - X_v.l('AfifeAg_d_f',t,k,s,m,p)  + X_v.l('AveyimAg_r_f',t,k,s,m,p)
                                           + X_v.l('KpongAg_r_f',t,k,s,m,p)  + X_v.l('AfifeAg_r_f',t,k,s,m,p)  + X_v.l('KPONG_rel_f',t,k,s,m,p)
                                           - X_v.l('AccraUr_u_f',t,k,s,m,p)  + eps;
*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
check_wat_use_p('AfifeAg_u_f',t,k,s,m,p) =         X_v.l('19_Senchi_v_f',t,k,s,m,p)   - X_v.l('20_Kpong_v_f',t,k,s,m,p)  - X_v.l('KpongAg_d_f',t,k,s,m,p)
                                           - X_v.l('AccraUr_d_f',t,k,s,m,p)  - X_v.l('AveyimAg_d_f',t,k,s,m,p)  + X_v.l('KpongAg_r_f',t,k,s,m,p)
                                           + X_v.l('AccraUr_r_f',t,k,s,m,p)  + X_v.l('AveyimAg_r_f',t,k,s,m,p)  + X_v.l('KPONG_rel_f',t,k,s,m,p)
                                           - sum((j),hectares_j_v.l('AfifeAg_u_f',j,t,k,s,m,p)* Bu_p('AfifeAg_u_f',j,k)) + eps;
*************************************************************************************************************************************************************************************

Parameter
*Agricultural Data
Yield_data_p           (aguse,j,      r      )   crop yields
Price_data_p           (aguse,j,      r      )   crops prices data
RHS_p                  (aguse,    t,  r,  m  )   available land in production

use_data_p             (uruse                )   Urban water supply
pop_data_p             (uruse                )   Population
HHsize_data_p          (uruse                )   Household size
Ur_price_data_p        (uruse                )   Urban water price

*Water
source_data_p          (inflow,           k,s)   headwater flows
Bu_data_p              (aguse,            j,k)   Per hectare crop water demand
Be_data_p              (evap,             res)   evaporation in meters
Bp_data_p              (precip,           res)   precipitation in meters

wat_stock0_p           (res                  )   stock initial
wat_flows_p            (i,        t,k,  s,m,p)   flows of all kind by period
riv_flows_p            (river,    t,k,  s,m,p)   river flows by period
head_flows_p           (inflow,   t,k,  s,m,p)   head water flows by period
wat_stocks_p           (res,      t,k,  s,m,p)   stocks by period
Ave_flow_p             (river,      k,  s,m,p)   average flows at gauging stations

WaterUse_r_j_p         (j,        t,k,r,s,m,p)   ag water use by crop and country
WatAguse_r_p           (          t,k,r,s,m,p)   ag water use by country
Wat_grains_r_p         (          t,k,r,s,m,p)   water use for grain crop production
Wat_veges_r_p          (          t,k,r,s,m,p)   water use for vegetable crop production

UrWateruse_p           (uruse,    t,k,  s,m,p)   urban water use by use node
Urwatuse_r_p           (          t,k,r,s,m,p)   urban water use by country
Water_use_r_p          (          t,k,r,s,m,p)   total water use by country (ag+urban)

hectares_j_p           (aguse,j,  t,k,  s,m,p)   irrigated land use by crop and use node
hectares_p             (aguse,    t,k,  s,m,p)   irrigated land use by use node
land_grains_r_p        (          t,k,r,s,m,p)   grian irrigated land use by country
land_veges_r_p         (          t,k,r,s,m,p)   vegetable irrigated land use by country


Power_prod_p           (res,hydro,t,k,  s,m,p)   hydropwer produced from reservoirs
quantity_supply_p      (          t,k,r,s,m,p)   hydropower production_supply by country
quantity_demand_p      (          t,k,r,s,m,p)   hydropower demand by country

price_demand_p         (          t,k,r,s,m,p)   hydropower demand price
price_supply_p         (          t,k,r,s,m,p)   hydropower supply price

tot_demand_p           (          t,k,  s,m,p)   total demand
tot_supply_p           (          t,k,  s,m,p)   total supply

G_rev_hydro_p          (          t,k,r,s,m,p)
cons_surp_p            (          t,k,r,s,m,p)   Consumer Surplus
prod_surp_p            (          t,k,r,s,m,p)   Producer Surplus
export_p               (          t,k,r,s,m,p)   Exports
import_p               (          t,k,r,s,m,p)   Imports

FDamage_p              (river,    t,k,  s,m,p)    flood damge reduction benefits for Ghana

dam_cost_p             (              r,  m  )    dam construction env and maitenance cost to Ghana

TotalAg_Ben_p          (              r,s,m,p)    total ag benefits to riparian
TotalUr_Ben_p          (              r,s,m,p)    total ur benefits to riparian
TotalRec_Ben_p         (              r,s,m,p)    total rec benefits to riparian
TotalEner_Ben_p        (              r,s,m,p)    total ener benefits to riparian
TotalFDamages_p        (              r,s,m,p)    total flood damages avioded to riparian
Tot_Ben_r_p            (              r,s,m,p)    total basin-wide benefits
;

*--------------------------------------------------------------------------------------------------------------------------------------------------*
*Data used in the model
Yield_data_p           (aguse,j,    r      ) = Yield_data_p          (aguse,j,    r      )+ eps;
Price_data_p           (aguse,j,    r      ) = Price_data_p          (aguse,j,    r      )+ eps;
RHS_p                  (aguse,  t,  r,  m  ) = RHS_p                 (aguse,  t,  r,  m  )+ eps;

use_data_p             (uruse              ) = use_p                  (uruse             )+ eps;
pop_data_p             (uruse              ) = pop_p                  (uruse             )+ eps;
HHsize_data_p          (uruse              ) = HHsize_P               (uruse             )+ eps;
Ur_price_data_p        (uruse              ) = Ur_price_p             (uruse             )+ eps;


Bu_data_p              (aguse,           j,k)= Bu_p                  (aguse,j,          k)+ eps;
Be_data_p              (evap,            res)= Be_p                  (evap,           res)+ eps;
Bp_data_p              (precip,          res)= Bp_p                  (precip,         res)+ eps;

*Water (Million m3)and Land Use
source_data_p          (inflow,         k,s) = sourc_p               (inflow,         k,s)+ eps;

wat_stock0_p           (res                ) = z0_p                  (res                )+ eps;
wat_flows_p            (i,      t,k,  s,m,p) = X_v.l                 (i,      t,k,  s,m,p)+ eps;
riv_flows_p            (river,  t,k,  s,m,p) = X_v.l                 (river,  t,k,  s,m,p)+ eps;
head_flows_p           (inflow, t,k,  s,m,p) = X_v.l                 (inflow, t,k,  s,m,p)+ eps;
wat_stocks_p           (res,    t,k,  s,m,p) = Z_v.l                 (res,    t,k,  s,m,p)+ eps;
Ave_flow_p             (river,    k,  s,m,p) = Ave_flow_v.l          (river,    k,  s,m,p)+ eps;

WatAguse_r_p           (        t,k,r,s,m,p) = WatAguse_r_v.l        (        t,k,r,s,m,p)+ eps;
Wat_grains_r_p         (        t,k,r,s,m,p) = Wat_grains_r_v.l      (        t,k,r,s,m,p)+ eps;
Wat_veges_r_p          (        t,k,r,s,m,p) = Wat_veges_r_v.l       (        t,k,r,s,m,p)+ eps;


UrWateruse_p           (uruse,  t,k,  s,m,p) = UrWateruse_v.l        (uruse,  t,k,  s,m,p)+ eps;
Urwatuse_r_p           (        t,k,r,s,m,p) = Urwatuse_r_v.l        (        t,k,r,s,m,p)+ eps;
Water_use_r_p          (        t,k,r,s,m,p) = Water_use_r_v.l       (        t,k,r,s,m,p)+ eps;

hectares_j_p           (aguse,j,t,k,  s,m,p) = hectares_j_v.l        (aguse,j,t,k,  s,m,p)+ eps;
hectares_p             ( aguse, t,k,  s,m,p) = sum((j),hectares_j_v.l(aguse,j,t,k,  s,m,p))+ eps;
land_grains_r_p        (        t,k,r,s,m,p) = land_grains_r_v.l     (        t,k,r,s,m,p)+ eps;
land_veges_r_p         (        t,k,r,s,m,p) = land_veges_r_v.l      (        t,k,r,s,m,p)+ eps;

Power_prod_p (res,hydro,t,k,s,m,p)$(bh(res,hydro)) = Power_prod_v.l  (res,hydro,t,k, s,m,p)+ eps;
quantity_supply_p      (        t,k,r,s,m,p) = quantity_supply_v.l   (        t,k,r,s,m,p)+ eps;
quantity_demand_p      (        t,k,r,s,m,p) = quantity_demand_v.l   (        t,k,r,s,m,p)+ eps;

price_demand_p         (        t,k,r,s,m,p) = price_demand_v.l      (        t,k,r,s,m,p)+ eps;
price_supply_p         (        t,k,r,s,m,p) = price_supply_v.l      (        t,k,r,s,m,p)+ eps;

tot_demand_p           (        t,k,  s,m,p) = tot_demand_v.l        (        t,k,  s,m,p)+ eps;
tot_supply_p           (        t,k,  s,m,p) = tot_supply_v.l        (        t,k,  s,m,p)+ eps;

G_rev_hydro_p          (        t,k,r,s,m,p) = G_rev_hydro_v.l       (        t,k,r,s,m,p)+ eps;

cons_surp_p            (        t,k,r,s,m,p) = cons_surp_v.l         (        t,k,r,s,m,p)+ eps;
prod_surp_p            (        t,k,r,s,m,p) = prod_surp_v.l         (        t,k,r,s,m,p)+ eps;

export_p               (        t,k,r,s,m,p) = export_v.l            (        t,k,r,s,m,p)+ eps;
import_p               (        t,k,r,s,m,p) = -(export_v.l          (        t,k,r,s,m,p))+ eps;


Dam_cost_p             (            r,  m  ) = Dam_cost              (            r,  m  ) + eps;

FDamage_p     ('12_Pwalugu_v_f',t,k,s,m,p) = FDamage_v.l ('12_Pwalugu_v_f', t,k,s,m,p) + eps;

TotalAg_Ben_p          (r,          s,m,p) = TotalAg_Ben_v.l     (r,            s,m,p) + eps;
TotalUr_Ben_p          (r,          s,m,p) = TotalUr_Ben_v.l     (r,            s,m,p) + eps;
TotalRec_Ben_p         (r,          s,m,p) = TotalRec_Ben_v.l    (r,            s,m,p) + eps;
TotalEner_Ben_p        (r,          s,m,p) = TotalEner_Ben_v.l   (r,            s,m,p) + eps;
TotalFDamages_p        (r,          s,m,p) = TotalFDamages_v.l   (r,            s,m,p) + eps;

Tot_Ben_r_p            (r,          s,m,p) = Tot_Ben_r_v.l       (r,            s,m,p) + eps;




*--------------------------------------------------------------------------------------------------------------------------------------------------*
* Next we use GAMS' GDX facility to write to an excel spreadsheet  import_p Tot_Ben_r_p

execute_unload "Volta_Basin_Optimization_Model.gdx"

Yield_data_p  Price_data_p  RHS_p  source_p  use_data_p  pop_data_p HHsize_data_p  Ur_price_data_p
Bu_data_p   Be_data_p  Bp_data_p wat_flows_p riv_flows_p head_flows_p wat_stocks_p wat_stock0_p
Ave_flow_p WatAguse_r_p Wat_grains_r_p Wat_veges_r_p UrWateruse_p Urwatuse_r_p Water_use_r_p
hectares_j_p hectares_p land_grains_r_p land_veges_r_p Power_prod_p quantity_supply_p
quantity_demand_p price_demand_p price_supply_p tot_demand_p tot_supply_p  G_rev_hydro_p cons_surp_p
prod_surp_p export_p import_p FDamage_p TotalAg_Ben_p TotalUr_Ben_p TotalEner_Ben_p
TotalRec_Ben_p TotalFDamages_p  dam_cost_p  check_wat_use_p check_wat_stock_p  mod_stat_p
;


$onecho > gdxxrwout.txt

i=Volta_Basin_Optimization_Model.gdx
o=Volta_Basin_Optimization_Model.xlsm

epsout = 0

par = Yield_data_p            rng =  data_crop_yield!c4            Cdim = 0
par = Price_data_p            rng =  data_crop_prices!c4           Cdim = 0
par = RHS_p                   rng =  data_avail_irr_land!c4        Cdim = 0

par = source_p                rng =  data_head_flows!c4            Cdim = 0
par = Bu_data_p               rng =  data_crop_use!c4              Cdim = 0
par = Be_data_p               rng =  data_evaporation!c4           Cdim = 0
par = Bp_data_p               rng =  data_precipitation!c4         Cdim = 0

par = use_data_p              rng =  data_urban_wat_supply!c4      Cdim = 0
par = pop_data_p              rng =  data_population!c4            Cdim = 0
par = HHsize_data_p           rng =  data_hh_size!c4               Cdim = 0
par = Ur_price_data_p         rng =  data_urban_wat_price!c4       Cdim = 0

par = dam_cost_p              rng = data_dam_costs!c4               Cdim = 0


par = wat_flows_p             rng =  opt_water_flows!c4            Cdim = 0
par = riv_flows_p             rng =  opt_gauge_flows!c4            Cdim = 0
par = head_flows_p            rng =  opt_head_flows!c4             Cdim = 0

par = wat_stock0_p            rng =  data_res_start_vols!c4        Cdim = 0
par = wat_stocks_p            rng =  opt_water_stocks!c4           Cdim = 0
par = Ave_flow_p              rng =  opt_ave_flows!c4              Cdim = 0

par = Wat_grains_r_p          rng =  opt_grains_watuse_r!c4        Cdim = 0
par = Wat_veges_r_p           rng =  opt_veges_watuse_r!c4         Cdim = 0
par = WatAguse_r_p            rng =  opt_ag_water_use_r!c4         Cdim = 0

par = UrWateruse_p            rng =  opt_ur_water_use_node!c4      Cdim = 0
par = Urwatuse_r_p            rng =  opt_ur_water_use_r!c4         Cdim = 0

par = Water_use_r_p           rng =  opt_water_use_ctry!c4         Cdim = 0

par = hectares_j_p            rng =  opt_ha_by_crop!c4             Cdim = 0
par = hectares_p              rng =  opt_ha_by_irr_area!c4         Cdim = 0
par = land_grains_r_p         rng =  opt_grains_ha_by_r!c4         Cdim = 0
par = land_veges_r_p          rng =  opt_veges_ha_r!c4             Cdim = 0

par = Power_prod_p            rng = opt_ener_prod_res!c4           Cdim = 0
par = quantity_supply_p       rng = opt_ener_supply!c4             Cdim = 0
par = quantity_demand_p       rng = opt_ener_demand!c4             Cdim = 0

par = price_demand_p          rng = opt_ener_dd_price!c4           Cdim = 0
par = price_supply_p          rng = opt_ener_ss_price!c4           Cdim = 0

par = tot_demand_p            rng = opt_tot_power_dd!c4            Cdim = 0
par = tot_supply_p            rng = opt_tot_power_ss!c4            Cdim = 0

par = G_rev_hydro_p           rng = opt_hydropower_rev!c4          Cdim = 0

par = cons_surp_p             rng = opt_ener_trade_CS!c4           Cdim = 0
par = prod_surp_p             rng = opt_ener_trade_PS!c4           Cdim = 0

par = export_p                rng = opt_ener_exports!c4            Cdim = 0
par = import_p                rng = opt_ener_imports!c4            Cdim = 0

par = FDamage_p               rng =opt_flood_damages!c4            Cdim = 0

par = TotalAg_Ben_p           rng = opt_total_agben!c4             Cdim = 0
par = TotalUr_Ben_p           rng = opt_total_urban!c4             Cdim = 0
par = TotalEner_Ben_p         rng = opt_total_enerben!c4           Cdim = 0
par = TotalRec_Ben_p          rng = opt_total_recBen!c4            Cdim = 0
par = TotalFDamages_p         rng = opt_total_fld_dmges!c4         Cdim = 0

*par =  Tot_Ben_r_p            rng = opt_total_r!c4                 Cdim = 0

* model checks
par = check_wat_stock_p       rng =zzz_check_water_stocks!c5       Cdim = 0
par = check_wat_use_p         rng =zzz_check_water_use!c4          Cdim = 0

par = mod_stat_p              rng =zzz_check_model_stat!c4         Cdim = 0

*$offtext
$offecho
execute 'gdxxrw.exe @gdxxrwout.txt trace=2';
****************************************************************************************************************************************************
* THE END                                                                                                                                          *
****************************************************************************************************************************************************
