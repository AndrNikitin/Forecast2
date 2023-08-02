<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Forecast.aspx.cs" Inherits="KazGidroMetWeb.Forecast" MasterPageFile="~/MasterPage.Master" %>

<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.2, Version=11.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>

<%@ Register assembly="DevExpress.Web.ASPxEditors.v11.2, Version=11.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dxe" %>

<%@ Register assembly="DevExpress.Web.v11.2, Version=11.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxTabControl" tagprefix="dxtc" %>
<%@ Register assembly="DevExpress.Web.v11.2, Version=11.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxClasses" tagprefix="dxw" %>

<%@ Register assembly="DevExpress.Web.v11.2, Version=11.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxRoundPanel" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v11.2, Version=11.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPanel" tagprefix="dx" %>

<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v11.2, Version=11.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>

<asp:Content id="Content1" ContentPlaceHolderid="head" runat="server">
<style type="text/css">
    table { border-collapse: collapse; }

    
</style>
<!--   java scripts  -->
<script src="js/jquery-1.11.0.js"></script>
<script src="js/jquery-ui-1.10.4.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="css/jquery-ui.css" />
<script>
function custom_alert( titleMsg ) {
    $("<div></div>").html('•- небол. дождь<br>••- дождь<br>•••- сильн. дождь<br>•• R –кратко-врем.дождь с грозой<br>•&lowast; - небол. осадки<br>••&lowast; - осадки<br>••&lowast;&lowast; - сильн. осад.<br>&lowast; - небольш. снег<br>&lowast;&lowast; - снег<br>&lowast;&lowast;&lowast; - сильный снег<br>&lowast;&uarr;&rarr; метель снег<br>( ) - местами<br>  - в горных, предгорных районах<br>&uarr;&rarr; - метель<br>&darr;&rarr; - низовая метель<br>&uArr;&rArr; - сильн метель<br>&#9650; - град<br>&equiv; - туман<br>&#126; - гололед<br>Б/о- без осадков<br>Н - ночью<br>Д - днем<br>R - гроза<br>S - пыльная буря<br>&nabla; - шквал<br>вр. – временами<br>Температура:<br><u>день, °С</u><br>ночь, °С<br>с-север<br>ю-юг<br>з-запад<br>в-восток<br>св-северо-восток<br>юв-юго-восток<br>юз-юго-запад<br>сз-северо-запад').dialog({
        title: titleMsg,
        resizable: true,
        modal: false,
        buttons: {
            "OK": function () {
                $(this).dialog("close");
            }
        }
    });
}

window.addEventListener('DOMContentLoaded', function() {
var rows = document.querySelectorAll('tr');
var textsToRemove = ['Уточнение', '1-е сутки', '2-3 сутки', 'Оцифр. 3с.'];

var counts = {};
for (var i = 0; i < rows.length; i++) {
var row = rows[i];
var tds = row.querySelectorAll('td');
var text = tds[1] ? tds[1].innerText.trim() : '';

if (textsToRemove.includes(text)) {
counts[text] = (counts[text] || 0) + 1;


if (counts[text] > 1) {
  row.parentNode.removeChild(row);
}
}
}
});
  




</script>





</asp:Content>
<asp:Content id="Content2" ContentPlaceHolderid="ContentPlaceHolder1" runat="server">
    
    <table width="100%" style="font-family: 'Segoe UI'; font-size: medium; color: #FFFFFF;">    
            <tr>
                <td>
                    <u style="font-size: x-large">Краткосрочное прогнозирование</u>
                </td>
            </tr>        
            <tr>
                <td >
                    <table width="100%" valign="top">
                        <tr>
                            <td>
                            
                            </td>
                            <td>
                                <table width="100%">
                        <tr>
                            <td width="50%">Выбор области :
                                <asp:DropDownList id="DropDownList1" runat="server" 
                                    DataSourceid="SqlDataSourceOblast" DatatextField="oblast" 
                                    DataValueField="oblast" Width="100%" Font-Names="Segoe UI" 
                                    Font-Size="Medium" AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                            <td width="50%">Выбор дня :
                                <dxe:ASPxDateEdit id="ASPxDateEdit1" runat="server" 
                                    ondatechanged="ASPxDateEdit1_DateChanged" Spacing="0"
                                    Width="100%" Font-Names="Segoe UI" Font-Size="Medium" AutoPostBack="True">
                                    <CalendarProperties>
                                        <HeaderStyle Spacing="1px" />
                                    </CalendarProperties>
                                </dxe:ASPxDateEdit>
                            </td>
                            <td>
                                <dxe:ASPxButton id="btnButtonReport" runat="server" onclick="btnButtonReport_Click" 
                                    text="Отчет" Width="100px" Enabled="true"  Visible="true"
                                    CssFilePath="~/App_Themes/Office2010Blue/{0}/styles.css" 
                                    CssPostfix="Office2010Blue" 
                                    SpriteCssFilePath="~/App_Themes/Office2010Blue/{0}/sprite.css" 
                                    Height="60px">
                                    <Image Url="~/img/microsoft_word_32_32.png">
                                    </Image>
                                </dxe:ASPxButton>
                            </td>
                            <td>
                                <dxe:ASPxButton id="btnAddForecast" runat="server" onclick="btnAddForecastNpgsql_Click" 
                                    text="Добавить" Width="100px" Enabled="true"  Visible="false" 
                                    CssFilePath="~/App_Themes/Office2010Blue/{0}/styles.css" 
                                    CssPostfix="Office2010Blue" 
                                    SpriteCssFilePath="~/App_Themes/Office2010Blue/{0}/sprite.css" 
                                    Height="60px">
                                    <Image Url="~/img/32add.png"></Image>
                                </dxe:ASPxButton>
                            </td>
                        </tr>
                        <tr>
                            <td colspan=2 align=center>
                                <br />
                            </td>
                        </tr>
                    </table>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <dxwgv:ASPxGridView id="ASPxGridView5" runat="server" 
                                    AutoGenerateColumns="False" DataSourceID="SqlDataSource5" 
                                    KeyFieldName="newcolumn" Width="100%" onrowupdating="ASPxGridView5_RowUpdating" 
                                    onrowvalidating="ASPxGridView5_RowValidating" 
                                    onstartrowediting="ASPxGridView5_StartRowEditing" 
                                    oncelleditorinitialize="ASPxGridView5_CellEditorInitialize" 
                                    onhtmleditformcreated="ASPxGridView5_HtmlEditFormCreated">
                        <SettingsPager Visible="False">
			
                        </SettingsPager>
                        <Columns>
                            <dxwgv:GridViewCommandColumn VisibleIndex="0" Width="50px">
                                <EditButton Visible="True" text="Редактировать">
                                </EditButton>
                                <CancelButton text="Отмена">
                                </CancelButton>
                                <UpdateButton text="Сохранить">
                                </UpdateButton>
                            </dxwgv:GridViewCommandColumn>
                            <dxwgv:GridViewDataMemoColumn FieldName="newcolumn" ReadOnly="True" 
                                Visible="False" VisibleIndex="2">
                                <EditFormSettings Visible="False" />
                            </dxwgv:GridViewDataMemoColumn>
                            <dxwgv:GridViewDatatextColumn FieldName="forecastnote" VisibleIndex="3" 
                                Caption="Прогнозы">
                            </dxwgv:GridViewDatatextColumn>
                            <dxwgv:GridViewDatatextColumn FieldName="forecastdayid" VisibleIndex="7" 
                                Width="50px" Visible="False">
                            </dxwgv:GridViewDatatextColumn>
                            <dxwgv:GridViewDatatextColumn Caption="Сутки" Name="forecastdayiddecode" 
                                VisibleIndex="1" Width="50px">
                            <DataItemTemplate>
                                <%# (Eval("forecastdayid").ToString() == "0") ? "Уточнение" : 
                                    (Eval("forecastdayid").ToString() == "1") ? "1-е сутки" :
                                    (Eval("forecastdayid").ToString() == "2") ? "2-3 сутки" :
                                    (Eval("forecastdayid").ToString() == "3") ? "Оцифр. 3с." :                                
                                    "<a href='x'>" + Eval("forecastdayid") + "</a>"%>
                            </DataItemTemplate>
                            </dxwgv:GridViewDatatextColumn>
                            <dxwgv:GridViewDatatextColumn FieldName="tnmin" Visible="False" 
                                VisibleIndex="8">
                            </dxwgv:GridViewDatatextColumn>
                            <dxwgv:GridViewDatatextColumn FieldName="oblast" Visible="False" 
                                VisibleIndex="4">
                            </dxwgv:GridViewDatatextColumn>
                            <dxwgv:GridViewDatatextColumn FieldName="tnminmes" Visible="False" 
                                VisibleIndex="5">
                            </dxwgv:GridViewDatatextColumn>
                            <dxwgv:GridViewDatatextColumn FieldName="tnmaxmes" Visible="False" 
                                VisibleIndex="6">
                            </dxwgv:GridViewDatatextColumn>
                        </Columns>                        
                        
                        <Templates>
            <EditForm>
            
            <dxtc:ASPxPageControl runat="server" id="pageControl" Width="100%">
                        <TabPages>
                            <dxtc:TabPage text="Прогноз текст" Visible="true">
                                <ContentCollection>
                                    <dxw:ContentControl runat="server">
                                        <dxe:ASPxMemo runat="server" id="ASPxMemoEditor1" text='<%# Eval("forecastnote")%>' Width="100%"
                                            Height="100px" ClientInstanceName="theMemo">
                                        </dxe:ASPxMemo>
                                    </dxw:ContentControl>
                                </ContentCollection>
                            </dxtc:TabPage>
                            <dxtc:TabPage text="Оцифровывание прогноза по области" Visible="true">
                                <ContentCollection>
                                    <dxw:ContentControl runat="server">
                                        <table width="100%">
                                            <tr align="center">
                                                <td></td>
                                                <td colspan="12" style="border-top-style: solid; border-top-width: medium; font-size: large;">
                                                    Ночь
                                                </td>
                                                <td colspan="12" style="border-top-style: solid; border-top-width: medium; border-left-style: solid; border-left-width: medium; font-size: large;">
                                                    День
                                                </td>
                                            </tr>
                                            <tr align="center">
                                                <td></td>
                                                <td colspan="4" style="font-size: medium; border-top-style: solid; border-top-width: thin; border-left-style: solid; border-left-width: thin;">
                                                    Основное
                                                </td>
                                                <td colspan="4" style="font-size: medium; border-top-style: solid; border-top-width: thin; border-left-style: solid; border-left-width: thin;">
                                                    Местами
                                                </td>
                                                <td colspan="4" style="font-size: medium; border-top-style: solid; border-top-width: thin; border-left-style: solid; border-left-width: thin;">
                                                    Доп.
                                                </td>
                                                <td colspan="4" style="border-left-width: medium; border-left-style: solid; font-size: medium; border-top-style: solid; border-top-width: thin;">
                                                    Основное
                                                </td>
                                                <td colspan="4" style="font-size: medium; border-top-style: solid; border-top-width: thin; border-left-style: solid; border-left-width: thin; border-right-style: solid; border-right-width: thin;">
                                                    Местами
                                                </td>
                                                <td colspan="4" style="font-size: medium; border-top-style: solid; border-top-width: thin; border-left-style: solid; border-left-width: thin;">
                                                    Доп.
                                                </td>
                                            </tr>
                                            <tr align="center">
                                                <td style="font-weight: bold" width="100" align="left">
                                                    Температура,°
                                                </td>
                                                <td style="border-left-style: solid; border-left-width: thin" width="20">
                                                    от
                                                </td>
                                                <td>
                                                    <dxe:ASPxtextBox Width="100%" id="ASPxtextBoxtnmin" runat="server" text='<%# Eval("tnmin")%>'>
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td width="20">
                                                    до
                                                </td>
                                                <td>
                                                    <dxe:ASPxtextBox Width="100%" id="ASPxtextBoxtnmax" runat="server" text='<%# Eval("tnmax")%>'>
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td style="border-left-style: solid; border-left-width: thin" width="20">
                                                    от
                                                </td>
                                                <td>
                                                    <dxe:ASPxtextBox Width="100%" id="ASPxtextBoxtnminmes" runat="server" text='<%# Eval("tnminmes")%>'>
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td width="20">
                                                    до
                                                </td>
                                                <td>
                                                    <dxe:ASPxtextBox Width="100%" id="ASPxtextBoxtnmaxmes" runat="server" text='<%# Eval("tnmaxmes")%>'>
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                 <!-- Доп. ночь -->
                                                <td style="border-left-style: solid; border-left-width: thin" width="20">
                                                    от
                                                </td>
                                                <td>
                                                    <dxe:ASPxtextBox Width="100%" id="ASPxtextBoxtnminExtra" runat="server" text='<%# Eval("tnminExtra")%>'>
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td width="20">
                                                    до
                                                </td>
                                                <td>
                                                    <dxe:ASPxtextBox Width="100%" id="ASPxtextBoxtnmaxExtra" runat="server" text='<%# Eval("tnmaxExtra")%>'>
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <!-- end -->
                                                <td style="border-left-width: medium; border-left-style: solid" width="20">
                                                    от    
                                                </td>
                                                <td>
                                                    <dxe:ASPxtextBox Width="100%" id="ASPxtextBoxtdmin" runat="server" text='<%# Eval("tdmin")%>'>
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td width="20">
                                                    до
                                                </td>
                                                <td>
                                                    <dxe:ASPxtextBox Width="100%" id="ASPxtextBoxtdmax" runat="server" text='<%# Eval("tdmax")%>'>
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td style="border-left-style: solid; border-left-width: thin" width="20">
                                                    от
                                                </td>
                                                <td>
                                                    <dxe:ASPxtextBox Width="100%" id="ASPxtextBoxtdminmes" runat="server" text='<%# Eval("tdminmes")%>'>
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td width="20">
                                                    до
                                                </td>
                                                <td style="border-right-style: solid; border-right-width: thin">
                                                    <dxe:ASPxtextBox Width="100%" id="ASPxtextBoxtdmaxmes" runat="server" text='<%# Eval("tdmaxmes")%>'>
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <!-- Доп. -->
                                                <td style="border-left-style: solid; border-left-width: thin" width="20">
                                                    от
                                                </td>
                                                <td>
                                                    <dxe:ASPxtextBox Width="100%" id="ASPxtextBoxtdminExtra" runat="server" text='<%# Eval("tdminExtra")%>'>
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td width="20">
                                                    до
                                                </td>
                                                <td>
                                                    <dxe:ASPxtextBox Width="100%" id="ASPxtextBoxtdmaxExtra" runat="server" text='<%# Eval("tdmaxExtra")%>'>
                                                    </dxe:ASPxtextBox>
                                                </td>
                                            </tr>
                                            <tr align="center">
                                                <td style="font-weight: bold" align="left">
                                                    Осадки,мм
                                                </td>
                                                <td style="border-left-style: solid; border-left-width: thin">
                                                    тип
                                                </td>
                                                <td>
                                                    <dxe:ASPxComboBox Width="100%" id="ASPxComboBoxontype" runat="server" text='<%# Eval("ontype")%>'>
                                                        <Items>
                                                            <dxe:ListEditItem text=" "></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Жидкие, смешанные" Value="1"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Твердые" Value="2"></dxe:ListEditItem>
                                                        </Items>
                                                    </dxe:ASPxComboBox>
                                                </td>
                                                <td>
                                                    кол.
                                                </td>
                                                <td>
                                                    <dxe:ASPxComboBox Width="100%" id="ASPxComboBoxoncat" runat="server" text='<%# Eval("oncat")%>'>
                                                        <Items>
                                                            <dxe:ListEditItem text=" "></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Без осадков, сухая погода" Value="1"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Слабые осадки, небольшие" Value="2"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Осадки" Value="3"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Сильные осадки" Value="4"></dxe:ListEditItem>
                                                        </Items>
                                                    </dxe:ASPxComboBox>
                                                </td>
                                                <td style="border-left-style: solid; border-left-width: thin">
                                                    тип
                                                </td>
                                                <td>
                                                    <dxe:ASPxComboBox Width="100%" id="ASPxComboBoxontypemes" runat="server" text='<%# Eval("ontypemes")%>'>
                                                        <Items>
                                                            <dxe:ListEditItem text=" "></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Жидкие, смешанные" Value="1"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Твердые" Value="2"></dxe:ListEditItem>
                                                        </Items>
                                                    </dxe:ASPxComboBox>
                                                </td>
                                                <td>
                                                    кол.
                                                </td>
                                                <td>
                                                    <dxe:ASPxComboBox Width="100%" id="ASPxComboBoxoncatmes" runat="server" text='<%# Eval("oncatmes")%>'>
                                                        <Items>
                                                            <dxe:ListEditItem text=" "></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Без осадков, сухая погода" Value="1"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Слабые осадки, небольшие" Value="2"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Осадки" Value="3"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Сильные осадки" Value="4"></dxe:ListEditItem>
                                                        </Items>
                                                    </dxe:ASPxComboBox>
                                                </td>
                                                <td>
                                                     нп.
                                                </td>
                                                <td colspan=3>
                                                    <dxe:ASPxtextBox Width="100%" id="ASPxtextBoxDN" runat="server" text='<%# Eval("dntype")%>'>
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td style="border-left-width: medium; border-left-style: solid">
                                                    тип  
                                                </td>
                                                <td>
                                                    <dxe:ASPxComboBox Width="100%" id="ASPxComboBoxodtype" runat="server" text='<%# Eval("odtype")%>'>
                                                        <Items>
                                                            <dxe:ListEditItem text=" "></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Жидкие, смешанные" Value="1"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Твердые" Value="2"></dxe:ListEditItem>
                                                        </Items>
                                                    </dxe:ASPxComboBox>
                                                </td>
                                                <td>
                                                    кол.
                                                </td>
                                                <td>
                                                    <dxe:ASPxComboBox Width="100%" id="ASPxComboBoxodcat" runat="server" text='<%# Eval("odcat")%>'>
                                                        <Items>
                                                            <dxe:ListEditItem text=" "></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Без осадков, сухая погода" Value="1"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Слабые осадки, небольшие" Value="2"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Осадки" Value="3"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Сильные осадки" Value="4"></dxe:ListEditItem>
                                                        </Items>
                                                    </dxe:ASPxComboBox>
                                                </td>
                                                <td style="border-left-style: solid; border-left-width: thin">
                                                    тип
                                                </td>
                                                <td>
                                                    <dxe:ASPxComboBox Width="100%" id="ASPxComboBoxodtypemes" runat="server" text='<%# Eval("odtypemes")%>'>
                                                        <Items>
                                                            <dxe:ListEditItem text=" "></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Жидкие, смешанные" Value="1"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Твердые" Value="2"></dxe:ListEditItem>
                                                        </Items>
                                                    </dxe:ASPxComboBox>
                                                </td>
                                                <td>
                                                    кол.
                                                </td>
                                                <td style="border-right-style: solid; border-right-width: thin">
                                                    <dxe:ASPxComboBox Width="100%" id="ASPxComboBoxodcatmes" runat="server" text='<%# Eval("odcatmes")%>'>
                                                        <Items>
                                                            <dxe:ListEditItem text=" "></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Без осадков, сухая погода" Value="1"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Слабые осадки, небольшие" Value="2"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Осадки" Value="3"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Сильные осадки" Value="4"></dxe:ListEditItem>
                                                        </Items>
                                                    </dxe:ASPxComboBox>
                                                </td>
                                                <td>
                                                     нп.
                                                </td>
                                                <td colspan="3">
                                                   <dxe:ASPxtextBox Width="100%" id="ASPxtextBoxDD" runat="server" text='<%# Eval("ddtype")%>'>
                                                    </dxe:ASPxtextBox>
                                                </td>
                                            </tr>
                                            <tr align="center">
                                                <td style="font-weight: bold" align="left">
                                                    Ветер,м/с 
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium; border-left-style: solid; border-left-width: thin;">
                                                    от
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium">
                                                    <dxe:ASPxtextBox Width="100%" id="ASPxtextBoxwnmin" runat="server" text='<%# Eval("wnmin")%>'>
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium">
                                                    до
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium">
                                                    <dxe:ASPxtextBox Width="100%" id="ASPxtextBoxwnmax" runat="server" text='<%# Eval("wnmax")%>'>
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium; border-left-style: solid; border-left-width: thin;">
                                                    от
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium">
                                                    <dxe:ASPxtextBox Width="100%" id="ASPxtextBoxwnminmes" runat="server" text='<%# Eval("wnminmes")%>'>
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium">
                                                    до
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium">
                                                    <dxe:ASPxtextBox Width="100%" id="ASPxtextBoxwnmaxmes" runat="server" text='<%# Eval("wnmaxmes")%>'>
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td colspan="4"></td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium; border-left-style: solid; border-left-width: medium;">
                                                    от    
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium">
                                                    <dxe:ASPxtextBox Width="100%" id="ASPxtextBoxwdmin" runat="server" text='<%# Eval("wdmin")%>'>
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium">
                                                    до
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium">
                                                    <dxe:ASPxtextBox Width="100%" id="ASPxtextBoxwdmax" runat="server" text='<%# Eval("wdmax")%>'>
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium; border-left-style: solid; border-left-width: thin;">
                                                    от
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium">
                                                    <dxe:ASPxtextBox Width="100%" id="ASPxtextBoxwdminmes" runat="server" text='<%# Eval("wdminmes")%>'>
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium">
                                                    до
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium; border-right-style: solid; border-right-width: thin;">
                                                    <dxe:ASPxtextBox Width="100%" id="ASPxtextBoxwdmaxmes" runat="server" text='<%# Eval("wdmaxmes")%>'>
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td colspan="4"></td>
                                            </tr>
                                            <tr>
                                                <td style="font-weight: bold" valign="top"><br /></td>
                                                <td colspan="30"><br />

                                                    <dxwgv:ASPxGridView id="ASPxGridView5" runat="server" AutoGenerateColumns="False" DataSourceid="SqlDataSourceSymbol" KeyFieldName="id" Width="100%">
                                                    <SettingsPager Visible="False">
                                                    </SettingsPager>
                                                    <Columns>
                                                        <dxwgv:GridViewCommandColumn VisibleIndex="0" Width="50px">
                                                        </dxwgv:GridViewCommandColumn>
                                                        <dxwgv:GridViewDataMemoColumn FieldName="id" ReadOnly="True" 
                                                            Visible="False" VisibleIndex="2">
                                                            <EditFormSettings Visible="False" />
                                                        </dxwgv:GridViewDataMemoColumn>
                                                        <dxwgv:GridViewDatatextColumn FieldName="text" VisibleIndex="3"
                                                            Caption="Явления"></dxwgv:GridViewDatatextColumn>
                                                    </Columns>
                                                    <Templates>
                                                    <EditForm>
                                                    <dxtc:ASPxPageControl runat="server" id="pageControl" Width="100%">
                                                    <TabPages>
                                                    <dxtc:TabPage text="текст" Visible="true">
                                                    <ContentCollection>
                                                        <dxw:ContentControl id="ContentControl2" runat="server">
                                                            <dxe:ASPxMemo runat="server" id="ASPxMemoEditortext" text='<%# Eval("text")%>' Width="100%"
                                                                Height="50px" ClientInstanceName="mtext">
                                                            </dxe:ASPxMemo>
                                                        </dxw:ContentControl>
                                                        </ContentCollection>
                                                        </dxtc:TabPage>
                                                        </TabPages>
                                                        </dxtc:ASPxPageControl>
                                                    </EditForm>
                                                    </Templates>
                                                    </dxwgv:ASPxGridView>                                                
                                                
                                                    <dxe:ASPxMemo runat="server" id="ASPxMemoSymbol" text='<%# Eval("forecastsymbol")%>' Width="80%"
                                                        Height="50px" ClientInstanceName="theMemoSymbol">
                                                    </dxe:ASPxMemo>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-weight: bold" valign="top">
                                                    <br />
                                                    Прогноз
                                                </td>
                                                <td colspan="16">
                                                    <br />
                                                    <dxe:ASPxLabel Width="100%" id="ASPxLabel1" runat="server" text='<%# Eval("forecastnote")%>'>
                                                    </dxe:ASPxLabel>
                                                    <dxe:ASPxLabel Width="100%" id="ASPxLabel2" runat="server" text="">
                                                    </dxe:ASPxLabel>
                                                </td>
                                            </tr>
                                        </table>
                                    </dxw:ContentControl>
                                </ContentCollection>
                            </dxtc:TabPage>
                            <dxtc:TabPage text="г.Нур-Султан" Visible="true">
                                <ContentCollection>
                                    <dxw:ContentControl id="ContentControl1" runat="server">
                                        <table width="100%">
                                            <tr align="center">
                                                <td>
                                                
                                                </td>
                                                <td colspan="12" style="border-top-style: solid; border-top-width: medium; font-size: large;">
                                                    Ночь
                                                </td>
                                                <td colspan="12" style="border-top-style: solid; border-top-width: medium; border-left-style: solid; border-left-width: medium; font-size: large;">
                                                    День
                                                </td>
                                            </tr>
                                            <tr align="center">
                                                <td>
                                                
                                                </td>
                                                <td colspan="4" style="font-size: medium; border-top-style: solid; border-top-width: thin; border-left-style: solid; border-left-width: thin;">
                                                    Основное
                                                </td>
                                                <td colspan="4" style="font-size: medium; border-top-style: solid; border-top-width: thin; border-left-style: solid; border-left-width: thin;">
                                                    Местами
                                                </td>
                                                <td colspan="4" style="font-size: medium; border-top-style: solid; border-top-width: thin; border-left-style: solid; border-left-width: thin;">
                                                    Доп.
                                                </td>
                                                <td colspan="4" style="border-left-width: medium; border-left-style: solid; font-size: medium; border-top-style: solid; border-top-width: thin;">
                                                    Основное
                                                </td>
                                                <td colspan="4" style="font-size: medium; border-top-style: solid; border-top-width: thin; border-left-style: solid; border-left-width: thin; border-right-style: solid; border-right-width: thin;">
                                                    Местами
                                                </td>
                                                <td colspan="4" style="font-size: medium; border-top-style: solid; border-top-width: thin; border-left-style: solid; border-left-width: thin;">
                                                    Доп.
                                                </td>
                                            </tr>
                                            <tr align="center">
                                                <td style="font-weight: bold" width="100" align="left">
                                                    Температура,°
                                                </td>
                                                <td style="border-left-style: solid; border-left-width: thin" width="20">
                                                    от
                                                </td>
                                                <td>
                                                    <dxe:ASPxtextBox Width="100%" id="txttnmin" runat="server">
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td width="20">
                                                    до
                                                </td>
                                                <td>
                                                    <dxe:ASPxtextBox Width="100%" id="txttnmax" runat="server" >
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td style="border-left-style: solid; border-left-width: thin" width="20">
                                                    от
                                                </td>
                                                <td>
                                                    <dxe:ASPxtextBox Width="100%" id="txttnminmes" runat="server" >
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td width="20">
                                                    до
                                                </td>
                                                <td>
                                                    <dxe:ASPxtextBox Width="100%" id="txttnmaxmes" runat="server" >
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <!-- Доп. ночь -->
                                                <td style="border-left-style: solid; border-left-width: thin" width="20">
                                                    от
                                                </td>
                                                <td>
                                                    <dxe:ASPxtextBox Width="100%" id="txttnminExtra" runat="server">
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td width="20">
                                                    до
                                                </td>
                                                <td>
                                                    <dxe:ASPxtextBox Width="100%" id="txttnmaxExtra" runat="server">
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <!-- end -->
                                                <td style="border-left-width: medium; border-left-style: solid" width="20">
                                                    от    
                                                </td>
                                                <td>
                                                    <dxe:ASPxtextBox Width="100%" id="txttdmin" runat="server" >
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td width="20">
                                                    до
                                                </td>
                                                <td>
                                                    <dxe:ASPxtextBox Width="100%" id="txttdmax" runat="server" >
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td style="border-left-style: solid; border-left-width: thin" width="20">
                                                    от
                                                </td>
                                                <td>
                                                    <dxe:ASPxtextBox Width="100%" id="txttdminmes" runat="server" >
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td width="20">
                                                    до
                                                </td>
                                                <td style="border-right-style: solid; border-right-width: thin">
                                                    <dxe:ASPxtextBox Width="100%" id="txttdmaxmes" runat="server" >
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <!-- Доп. -->
                                                <td style="border-left-style: solid; border-left-width: thin" width="20">
                                                    от
                                                </td>
                                                <td>
                                                    <dxe:ASPxtextBox Width="100%" id="txttdminExtra" runat="server">
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td width="20">
                                                    до
                                                </td>
                                                <td>
                                                    <dxe:ASPxtextBox Width="100%" id="txttdmaxExtra" runat="server" >
                                                    </dxe:ASPxtextBox>
                                                </td>
                                            </tr>
                                            <tr align="center">
                                                <td style="font-weight: bold" align="left">
                                                    Осадки,мм
                                                </td>
                                                <td style="border-left-style: solid; border-left-width: thin">
                                                    тип
                                                </td>
                                                <td>
                                                    <dxe:ASPxComboBox Width="100%" id="cbontype" runat="server">
                                                        <Items>
                                                            <dxe:ListEditItem text="" Value="0"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Жидкие, смешанные" Value="1"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Твердые" Value="2"></dxe:ListEditItem>
                                                        </Items>
                                                    </dxe:ASPxComboBox>
                                                </td>
                                                <td>
                                                    кол.
                                                </td>
                                                <td>
                                                    <dxe:ASPxComboBox Width="100%" id="cboncat" runat="server">
                                                        <Items>
                                                            <dxe:ListEditItem text="" Value="0"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Без осадков, сухая погода" Value="1"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Слабые осадки, небольшие" Value="2"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Осадки" Value="3"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Сильные осадки" Value="4"></dxe:ListEditItem>
                                                        </Items>
                                                    </dxe:ASPxComboBox>
                                                </td>
                                                <td style="border-left-style: solid; border-left-width: thin">
                                                    тип
                                                </td>
                                                <td>
                                                    <dxe:ASPxComboBox Width="100%" id="cbontypemes" runat="server">
                                                        <Items>
                                                            <dxe:ListEditItem text="" Value="0"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Жидкие, смешанные" Value="1"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Твердые" Value="2"></dxe:ListEditItem>
                                                        </Items>
                                                    </dxe:ASPxComboBox>
                                                </td>
                                                <td>
                                                    кол.
                                                </td>
                                                <td>
                                                    <dxe:ASPxComboBox Width="100%" id="cboncatmes" runat="server" >
                                                        <Items>
                                                            <dxe:ListEditItem text=" " Value="0"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Без осадков, сухая погода" Value="1"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Слабые осадки, небольшие" Value="2"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Осадки" Value="3"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Сильные осадки" Value="4"></dxe:ListEditItem>
                                                        </Items>
                                                    </dxe:ASPxComboBox>
                                                </td>
                                                <td>
                                                     нп.
                                                </td>
                                                <td>
                                                    <dxe:ASPxtextBox Width="100%" id="txtdntype" runat="server">
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td colspan="2"></td>
                                                <td style="border-left-width: medium; border-left-style: solid">
                                                    тип  
                                                </td>
                                                <td>
                                                    <dxe:ASPxComboBox Width="100%" id="cbodtype" runat="server" >
                                                        <Items>
                                                            <dxe:ListEditItem text=" " Value="0"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Жидкие, смешанные" Value="1"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Твердые" Value="2"></dxe:ListEditItem>
                                                        </Items>
                                                    </dxe:ASPxComboBox>
                                                </td>
                                                <td>
                                                    кол.
                                                </td>
                                                <td>
                                                    <dxe:ASPxComboBox Width="100%" id="cbodcat" runat="server" >
                                                        <Items>
                                                            <dxe:ListEditItem text=" " Value="0"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Без осадков, сухая погода" Value="1"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Слабые осадки, небольшие" Value="2"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Осадки" Value="3"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Сильные осадки" Value="4"></dxe:ListEditItem>
                                                        </Items>
                                                    </dxe:ASPxComboBox>
                                                </td>
                                                <td style="border-left-style: solid; border-left-width: thin">
                                                    тип
                                                </td>
                                                <td>
                                                    <dxe:ASPxComboBox Width="100%" id="cbodtypemes" runat="server" >
                                                        <Items>
                                                            <dxe:ListEditItem text=" " Value="0"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Жидкие, смешанные" Value="1"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Твердые" Value="2"></dxe:ListEditItem>
                                                        </Items>
                                                    </dxe:ASPxComboBox>
                                                </td>
                                                <td>
                                                    кол.
                                                </td>
                                                <td style="border-right-style: solid; border-right-width: thin">
                                                    <dxe:ASPxComboBox Width="100%" id="cbodcatmes" runat="server" >
                                                        <Items>
                                                            <dxe:ListEditItem text=" " Value="0"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Без осадков, сухая погода" Value="1"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Слабые осадки, небольшие" Value="2"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Осадки" Value="3"></dxe:ListEditItem>
                                                            <dxe:ListEditItem text="Сильные осадки" Value="4"></dxe:ListEditItem>
                                                        </Items>
                                                    </dxe:ASPxComboBox>
                                                </td>
                                                <td>
                                                     нп.
                                                </td>
                                                <td>
                                                    <dxe:ASPxtextBox Width="100%" id="txtddtype" runat="server">
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td colspan="2"></td>
                                            </tr>
                                            <tr align="center">
                                                <td style="font-weight: bold" align="left">
                                                    Ветер,м/с 
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium; border-left-style: solid; border-left-width: thin;">
                                                    от
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium">
                                                    <dxe:ASPxtextBox Width="100%" id="txtwnmin" runat="server" >
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium">
                                                    до
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium">
                                                    <dxe:ASPxtextBox Width="100%" id="txtwnmax" runat="server" >
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium; border-left-style: solid; border-left-width: thin;">
                                                    от
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium">
                                                    <dxe:ASPxtextBox Width="100%" id="txtwnminmes" runat="server" >
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium">
                                                    до
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium">
                                                    <dxe:ASPxtextBox Width="100%" id="txtwnmaxmes" runat="server" >
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td colspan="4"></td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium; border-left-style: solid; border-left-width: medium;">
                                                    от    
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium">
                                                    <dxe:ASPxtextBox Width="100%" id="txtwdmin" runat="server" >
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium">
                                                    до
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium">
                                                    <dxe:ASPxtextBox Width="100%" id="txtwdmax" runat="server" >
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium; border-left-style: solid; border-left-width: thin;">
                                                    от
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium">
                                                    <dxe:ASPxtextBox Width="100%" id="txtwdminmes" runat="server" >
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium">
                                                    до
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: medium; border-right-style: solid; border-right-width: thin;">
                                                    <dxe:ASPxtextBox Width="100%" id="txtwdmaxmes" runat="server" >
                                                    </dxe:ASPxtextBox>
                                                </td>
                                                <td colspan="4"></td>
                                            </tr>
                                            <tr>
                                                <td style="font-weight: bold" valign="top"><br /></td>
                                                <td colspan="30"><br />
                                                
                                                <dxwgv:ASPxGridView id="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceid="SqlDataSourceSymbol" KeyFieldName="id" Width="100%">
                                                <SettingsPager Visible="False">
                                                </SettingsPager>
                                                <Columns>
                                                <dxwgv:GridViewCommandColumn VisibleIndex="0" Width="50px">
                                                </dxwgv:GridViewCommandColumn>
                                                <dxwgv:GridViewDataMemoColumn FieldName="id" ReadOnly="True" 
                                                    Visible="False" VisibleIndex="2">
                                                <EditFormSettings Visible="False" />
                                                </dxwgv:GridViewDataMemoColumn>
                                                <dxwgv:GridViewDatatextColumn FieldName="text" VisibleIndex="3"
                                                    Caption="Явления"></dxwgv:GridViewDatatextColumn>
                                                </Columns>                        
                                                <Templates>
                                                <EditForm>
                                                <dxtc:ASPxPageControl runat="server" id="pageControl" Width="100%">
                                                <TabPages>
                                                <dxtc:TabPage text="текст" Visible="true">
                                                    <ContentCollection>
                                                    <dxw:ContentControl id="ContentControl2" runat="server">
                                                    <dxe:ASPxMemo runat="server" id="ASPxMemoEditortextCity" text='<%# Eval("text")%>' Width="100%"
                                                    Height="50px" ClientInstanceName="mtext">
                                                    </dxe:ASPxMemo>
                                                    </dxw:ContentControl>
                                                    </ContentCollection>
                                                    </dxtc:TabPage>
                                                    </TabPages>
                                                    </dxtc:ASPxPageControl>
                                                    </EditForm>
                                                    </Templates>
                                                 </dxwgv:ASPxGridView>

                                                    <dxe:ASPxMemo runat="server" id="ASPxMemoSymbolCity" Width="80%"
                                                        Height="50px" ClientInstanceName="theMemoSymbolCity">
                                                    </dxe:ASPxMemo>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-weight: bold" valign="top">
                                                    <br />
                                                    Прогноз
                                                </td>
                                                <td colspan="16">
                                                    <br />
                                                    <dxe:ASPxLabel Width="100%" id="ASPxLabel3" runat="server" text='<%# Eval("forecastnote")%>'>
                                                    </dxe:ASPxLabel>
                                                    <dxe:ASPxLabel Width="100%" id="ASPxLabel4" runat="server" text="">
                                                    </dxe:ASPxLabel>
                                                    
                                                </td>
                                            </tr>
                                        </table>
                                    </dxw:ContentControl>
                                </ContentCollection>
                            </dxtc:TabPage>           
                        </TabPages>
                    </dxtc:ASPxPageControl>
            
                <div style="text-align: left; padding: 2px">
                    <dxwgv:ASPxGridViewTemplateReplacement id="UpdateButton" ReplacementType="EditFormUpdateButton"
                        runat="server">
                    </dxwgv:ASPxGridViewTemplateReplacement>
                    <dxwgv:ASPxGridViewTemplateReplacement id="CancelButton" ReplacementType="EditFormCancelButton"
                        runat="server">
                    </dxwgv:ASPxGridViewTemplateReplacement>
                </div>
            </EditForm>
        </Templates>

                    </dxwgv:ASPxGridView>
                            </td>
                        </tr>                        
                        <tr>
                            <td>
                            
                            </td>
                            <td>
                                <table width="100%">
                                    <tr>
                                        <td align=center width="50%">
                                            &nbsp;</td>
                                        <td align=center width="50%">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                            
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    
                <br />
                    
                    <br />
                </td>
            </tr>
            <tr>            
                <td colspan=2>
                    <asp:SqlDataSource id="SqlDataSourceOblast" runat="server" ProviderName="Npgsql" 
                        SelectCommand="SELECT DISTINCT oblast FROM oblast Order by oblast"></asp:SqlDataSource>
                    <asp:SqlDataSource id="SqlDataSourceSymbol" runat="server" ProviderName="Npgsql"
                        SelectCommand="SELECT id, text FROM symbol">
                    </asp:SqlDataSource>

                    <asp:SqlDataSource id="SqlDataSource5" runat="server" ProviderName="Npgsql"
                        DeleteCommand="DELETE FROM Forecast WHERE newcolumn = @newcolumn" 
                        InsertCommand="INSERT INTO Forecast (forecastnote, forecastdayid, forecastsymbol) VALUES (@forecastnote, @forecastdayid, @forecastsymbol)" 
                        SelectCommand="SELECT forecastnote, oblast, day, Person, forecastdayid, dntype, ddtype, tnminExtra, tnmaxExtra, tdminExtra, tdmaxExtra, tnmin, tnmax, tnminmes, tnmaxmes, tdmin, tdmax, tdminmes, tdmaxmes, ontype, oncat, ontypemes, oncatmes, odtype, odcat, odtypemes, odcatmes, wnmin, wnmax, wnminmes, wdmin, wdmax, wdminmes, wdmaxmes, ismaster, newcolumn, wnmaxmes, date_modify, forecastsymbol FROM Forecast WHERE ((ismaster = @ismaster) AND (day = @day) AND (trim(oblast) = @oblast)) ORDER BY forecastdayid" 
                        UpdateCommand="UPDATE Forecast SET forecastnote = @forecastnote, tnmin = @tnmin, tnmax = @tnmax, tnminmes = @tnminmes, tnmaxmes = @tnmaxmes, tdmin = @tdmin, tdmax = @tdmax, tdminmes = @tdminmes, tdmaxmes = @tdmaxmes, oncat = @oncat, ontype = @ontype, oncatmes = @oncatmes, ontypemes = @ontypemes, odcat = @odcat, odtype = @odtype, odcatmes = @odcatmes, odtypemes = @odtypemes, wnmin = @wnmin, wnmax = @wnmax, wnminmes = @wnminmes, wnmaxmes = @wnmaxmes, wdmin = @wdmin, wdmax = @wdmax, wdminmes = @wdminmes, wdmaxmes = @wdmaxmes, tnminExtra = @tnminExtra, tnmaxExtra = @tnmaxExtra, tdminExtra = @tdminExtra, tdmaxExtra = @tdmaxExtra, dntype = @dntype, ddtype = @ddtype, Person = @user, date_modify = @date_modify, forecastsymbol = @forecastsymbol WHERE newcolumn = @newcolumn">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="ismaster" Type="Int16" />
                            <asp:ControlParameter Controlid="ASPxDateEdit1" 
                                Name="day" PropertyName="Value" Type="DateTime" />
                            <asp:ControlParameter Controlid="DropDownList1" 
                                DefaultValue="Акмолинская область" Name="oblast" PropertyName="SelectedValue" 
                                Type="String" />
                            
                        </SelectParameters>
                        <DeleteParameters>
                            <asp:Parameter Name="newcolumn" Type="Int32" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="forecastnote" Type="String" />
                            <asp:Parameter Name="forecastdayid" Type="Int16" />
                            <asp:Parameter Name="newcolumn" Type="Int32" />                            
                            <asp:Parameter Name="user" Type="String" />
                            <asp:Parameter Name="tnmin" Type="Int32" />
                            <asp:Parameter Name="tnmax" Type="Int32" />
                            <asp:Parameter Name="tnminmes" Type="Int32" />
                            <asp:Parameter Name="tnmaxmes" Type="Int32" />
                            <asp:Parameter Name="tdmin" Type="Int32" />
                            <asp:Parameter Name="tdmax" Type="Int32" />
                            <asp:Parameter Name="tdminmes" Type="Int32" />
                            <asp:Parameter Name="tdmaxmes" Type="Int32" />
                            <asp:Parameter Name="oncat" Type="Int32" />
                            <asp:Parameter Name="ontype" Type="Int32" />
                            <asp:Parameter Name="oncatmes" Type="Int32" />
                            <asp:Parameter Name="ontypemes" Type="Int32" />
                            <asp:Parameter Name="odcat" Type="Int32" />
                            <asp:Parameter Name="odtype" Type="Int32" />
                            <asp:Parameter Name="odcatmes" Type="Int32" />
                            <asp:Parameter Name="odtypemes" Type="Int32" />
                            <asp:Parameter Name="wnmin" Type="Int32" />
                            <asp:Parameter Name="wnmax" Type="Int32" />
                            <asp:Parameter Name="wnminmes" Type="Int32" />
                            <asp:Parameter Name="wnmaxmes" Type="Int32" />
                            <asp:Parameter Name="wdmin" Type="Int32" />
                            <asp:Parameter Name="wdmax" Type="Int32" />
                            <asp:Parameter Name="wdminmes" Type="Int32" />
                            <asp:Parameter Name="wdmaxmes" Type="Int32" />
                            <asp:Parameter Name="date_modify" Type="DateTime" />
                            <asp:Parameter Name="forecastsymbol" Type="String" />
                            <asp:Parameter Name="tnminExtra" Type="Int32" />
                            <asp:Parameter Name="tnmaxExtra" Type="Int32" />
                            <asp:Parameter Name="tdminExtra" Type="Int32" />
                            <asp:Parameter Name="tdmaxExtra" Type="Int32" />
                            <asp:Parameter Name="dntype" Type="String" />
                            <asp:Parameter Name="ddtype" Type="String" />
                        </UpdateParameters>
                        <InsertParameters>
                            <asp:Parameter Name="forecastnote" Type="String" />
                            <asp:Parameter Name="forecastdayid" Type="Int16" />
                            <asp:Parameter Name="forecastsymbol" Type="String" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
	

	

</asp:Content>
