#install.packages("gmailr", repos="http://cran.r-project.org")

library(gmailr)
library(stringr)
library(lubridate)
library(dplyr)

path="somedir/outreach_email_code/client_secret_asdfg5968-tjm4akcusa1235uvk.apps.googleusercontent.com.json"
gm_auth_configure(path=path)
gm_auth(cache=".secret")

send.msg <-  function(to_email=randomaccount@gmail.com;randomaccount@gmail.com',
                from_email=randomaccount@gmail.com',
                subj_email="ENIGMA Addiction Data sharing Invitation",
                html2send=NA,
                thread_id2use=NULL){
  if (is.character(html2send) & nchar(html2send)>100){
  email <- gm_mime() %>%
    gm_to(to_email) %>%
    gm_from(from_email) %>%
    gm_subject(subj_email) %>%
    gm_html_body(html2send)
    sending_info=gm_send_message(email,thread_id=thread_id2use)}
    # sending_info$sent.date=today('EST')
    # sneding_info$resend.date=today('EST')+ddays(30)}
  else {
    print('check html content')
    sending_info=NA
  }
   return(sending_info)
}


wrap_html_txt <- function(author_name=NA,
                          artical_title=NA,
                          journal_name=NA,
                          is.followup=FALSE){
# How to use:  
# txt2send=wrap_html_txt(msg_type='new_with_info',
#                        author_name='Zhipeng Cao',
#                        artical_title='Mapping adolescent reward anticipation, receipt, and prediction error during the monetary incentive delay task',
#                        journal_name='Human Brain Mapping')
# 
# txt2send=wrap_html_txt(msg_type='new_no_info',
#                        author_name='Zhipeng Cao')
# 
# txt2send=wrap_html_txt(msg_type='follow-up',
#                        author_name='Zhipeng Cao')
# 
if (!is.followup&is.character(author_name) & nchar(author_name)>1&!is.na(artical_title)&is.character(artical_title) & nchar(artical_title)>10 &!is.na(journal_name)&is.character(journal_name) & nchar(journal_name)>5){
txt='<p><img style="display: block; margin-left: auto; margin-right: auto;" src="http://enigma.ini.usc.edu/wp-content/uploads/2015/11/enigma_300DPI_small.png" width="316" height="197" /></p>
<p>Dear Dr. author_name,</p>
<p style="text-align: justify; text-justify: inter-ideograph;">My name is Zhipeng Cao.&nbsp;I am a&nbsp;post-doc&nbsp;working with Hugh Garavan and Scott Mackey in the&nbsp;ENIGMA-Addiction&nbsp;working group.&nbsp;&nbsp;We are undertaking a large-scale multi-site&nbsp;analysis of existing fMRI datasets related to substance use disorders within the framework of the&nbsp;<a href="https://www.enigmaaddictionconsortium.com/">ENIGMA Addiction consortium</a>. I noticed that you have published a great paper entitled " <em><strong>artical_title</strong></em>" in the journal of <strong><em>journal_name</em></strong> with your colleagues. <span style="text-decoration: underline;"><strong>I would like to invite you to contribute data to ongoing projects&nbsp;examining the neurobiological basis of&nbsp;substance&nbsp;use disorder using the framework of the&nbsp;<a href="http://enigma.ini.usc.edu/">ENIGMA</a>&nbsp;project.</strong></span><em> If you or your lab have already joined the working group, please ignore this message. I apologize&nbsp;for the&nbsp;multiple emails.</em></p>
<p style="text-align: justify; text-justify: inter-ideograph;">As you may know, ENIGMA Addiction is an international &ldquo;big data&rdquo; consortium which leverages the ENIGMA protocols for multisite meta- and mega-analyses to explore the genetic and neuroanatomical basis of addiction. Currently, the consortium has compiled structural MRI, behavioral, and genetic data collected from over 16k individuals across 51 labs on 5 continents. ENIGMA Addiction&rsquo;s most recent publication can be found&nbsp;<a href="https://ajp.psychiatryonline.org/doi/full/10.1176/appi.ajp.2018.17040415?url_ver=Z39.88-2003&amp;rfr_id=ori:rid:crossref.org&amp;rfr_dat=cr_pub%3dpubmed">here</a>. <span style="text-decoration: underline;"><strong>The consortium offers an excellent opportunity for your datasets to be re-used in high-impact, secondary publications after you have completed and published your primary analyses.</strong></span> Members of the group are also allowed to propose and lead their own projects with the consortium datasets.</p>
<p>For more information, please visit our website: <a href="https://www.enigmaaddictionconsortium.com/how-to-join">https://www.enigmaaddictionconsortium.com/how-to-join</a>. Feel free to let me know if you have further questions. If you would like, we could arrange a meeting with one of the group leaders (Hugh Garavan, Patricia Conrod, or Scott Mackey) to discuss other current projects and the ways in which your research program could benefit from joining the consortium.&nbsp;</p>
<p>Regards,&nbsp;</p>
<p>Zhipeng</p>
<p>Post-doc associate</p>
<p>ENIGMA Addiction working group</p>'

txt=str_replace(txt, 'author_name', author_name)
txt=str_replace(txt, 'artical_title', artical_title)
txt=str_replace(txt, 'journal_name', journal_name)}
else if (!is.followup&is.character(author_name) & nchar(author_name)>1&is.na(artical_title)&is.na(journal_name)){
txt='<p><img style="display: block; margin-left: auto; margin-right: auto;" src="http://enigma.ini.usc.edu/wp-content/uploads/2015/11/enigma_300DPI_small.png" width="316" height="197" /></p>
<p>Dear Dr. author_name,</p>
<p style="text-align: justify; text-justify: inter-ideograph;">My name is Zhipeng Cao.&nbsp;I am a&nbsp;post-doc&nbsp;working with Hugh Garavan and Scott Mackey in the&nbsp;ENIGMA-Addiction&nbsp;working group.&nbsp;&nbsp;We are undertaking a large-scale multi-site&nbsp;analysis of existing fMRI datasets related to substance use disorders within the framework of the&nbsp;<a href="https://www.enigmaaddictionconsortium.com/">ENIGMA Addiction consortium</a>. Given your great work in the area of addiction research, <span style="text-decoration: underline;"><strong>I would like to invite you to contribute data to ongoing projects&nbsp;examining the neurobiological basis of&nbsp;substance&nbsp;use disorder using the framework of the&nbsp;<a href="http://enigma.ini.usc.edu/">ENIGMA</a>&nbsp;project.</strong></span> <em> If you or your lab have already joined the working group, please ignore this message. I apologize&nbsp;for the&nbsp;multiple emails.</em></p>
<p style="text-align: justify; text-justify: inter-ideograph;">As you may know, ENIGMA Addiction is an international &ldquo;big data&rdquo; consortium which leverages the ENIGMA protocols for multisite meta- and mega-analyses to explore the genetic and neuroanatomical basis of addiction. Currently, the consortium has compiled structural MRI, behavioral, and genetic data collected from over 16k individuals across 51 labs on 5 continents. ENIGMA Addiction&rsquo;s most recent publication can be found&nbsp;<a href="https://ajp.psychiatryonline.org/doi/full/10.1176/appi.ajp.2018.17040415?url_ver=Z39.88-2003&amp;rfr_id=ori:rid:crossref.org&amp;rfr_dat=cr_pub%3dpubmed">here</a>. <span style="text-decoration: underline;"><strong>The consortium offers an excellent opportunity for your datasets to be re-used in high-impact, secondary publications after you have completed and published your primary analyses.</strong></span> Members of the group are also allowed to propose and lead their own projects with the consortium datasets.</p>
<p>For more information, please visit our website: <a href="https://www.enigmaaddictionconsortium.com/how-to-join">https://www.enigmaaddictionconsortium.com/how-to-join</a>. Feel free to let me know if you have further questions. If you would like, we could arrange a meeting with one of the group leaders (Hugh Garavan, Patricia Conrod, or Scott Mackey) to discuss other current projects and the ways in which your research program could benefit from joining the consortium.&nbsp;</p>
<p>Regards,&nbsp;</p>
<p>Zhipeng</p>
<p>Post-doc associate</p>
<p>ENIGMA Addiction working group</p>'
txt=str_replace(txt, 'author_name', author_name)} 
  else if (is.followup&is.character(author_name) & nchar(author_name)>1){
  txt='<p><img style="display: block; margin-left: auto; margin-right: auto;" src="http://enigma.ini.usc.edu/wp-content/uploads/2015/11/enigma_300DPI_small.png" width="316" height="197" /></p>
  <p>Dear Dr. author_name,</p>
  <p style="text-align: justify;">We havent heard from you since the last email. I am sending a follow-up email regarding the invitation for sharing your data with the ENIGMA Addiction working group. For more information, please visit our website: <a href="https://www.enigmaaddictionconsortium.com/how-to-join">https://www.enigmaaddictionconsortium.com/how-to-join</a>. Feel free to let me know if you have any questions. </p>
    <p>&nbsp;</p>
  <p>Regards,&nbsp;</p>
  <p>Zhipeng</p>
  <p>Post-doc associate</p>
  <p>ENIGMA Addiction working group</p>'  
  txt=str_replace(txt, 'author_name', author_name)}
  else {txt=NA}
return(txt)
}

parse.wos <- function(recs_xls='somedir/2021-09_outreatch/sample_wosrecord.xls',
                      substance_type='ALC'){
  df=readxl::read_xls(recs_xls)
  df['substance']=substance_type
  df.clean=data.frame(substance=df$substance,
                      paper=df$`Article Title`,
                      journal=df$`Journal ISO Abbreviation`,
                      year=df$`Publication Year`,
                      authors=df$`Author Full Names`,
                      reprint=df$`Reprint Addresses`,
                      contact_name=gsub(',.*','',df$`Reprint Addresses`),
                      contact_email=df$`Email Addresses`,
                      abstract=df$Abstract,
                      last_sent_date=NA,
                      thread_id=NA,
                      follow_up_date=NA,
                      keep=1)
  return(df.clean)
}

# create the outreach database
# alc1=parse.wos('F:/Google Drive/post-doc/Enigma track/my track/2021-09_outreatch/alc.xls',substance_type='ALC')
# alc2=parse.wos('F:/Google Drive/post-doc/Enigma track/my track/2021_02_outreach/alc_studies.xls',substance_type='ALC')
# alc3=parse.wos('F:/Google Drive/post-doc/Enigma track/my track/2020_outreach/alc_outreach_list2020_Nov.xls',substance_type='ALC')

# nic1=parse.wos('F:/Google Drive/post-doc/Enigma track/my track/2021-09_outreatch/nic.xls',substance_type='NIC')
# nic2=parse.wos('F:/Google Drive/post-doc/Enigma track/my track/2020_outreach/nic_outreach_list2020_Nov.xls',substance_type='NIC')

# opi=parse.wos('F:/Google Drive/post-doc/Enigma track/my track/2021-09_outreatch/opi.xls',substance_type='OPI')
# combined=parse.wos('F:/Google Drive/post-doc/Enigma track/my track/2021_02_outreach/savedrecs_1.xls',substance_type='ALC')

# df.outreach=rbind(alc1,alc2,alc3,nic1,nic2,opi,combined) %>% distinct(.)

# write.csv(df.outreach,
#           'F:/Google Drive/post-doc/Enigma track/my track/outreach_email_code/outreach_database_unchecked.csv',
#           row.names = FALSE)


# send the code for each row
databasefile='somedir/outreach_email_code/sample_outreach_database.csv'
emailbase='somerandommail@gmail.com;somerandom@gmail'
duration2fu=20
df=read.csv(databasefile) %>% mutate_all(as.character)
df$keep=as.numeric(df$keep)
today.date=today(tzone='EST')

for (rowi in c(1:nrow(df))){
  # FOR already sent dataframe, check if it is the time to follow-up?
  if(!is.na(df[rowi,'last_sent_date'])&!is.na(df[rowi,'thread_id'])&df[rowi,'keep']==1&!is.na(df[rowi,'follow_up_date'])){
   if (today.date>as.Date(df[rowi,'follow_up_date'])+ddays(1)){
     
     
     fu2send=wrap_html_txt(author_name=df[rowi,'contact_name'],
                           is.followup=TRUE)
     emailbook=paste(emailbase,df[rowi,'contact_email'],sep=';')
     send.msg (to_email= emailbook,
               from_email=randomaccount@gmail.com',
               subj_email="ENIGMA Addiction Data sharing Invitation",
               html2send=fu2send,
               thread_id2use=as.character(df[rowi,'thread_id']))
     df[rowi,'last_sent_date']=as.character(today.date)
     df[rowi, 'follow_up_date']=as.character(today.date+ddays(duration2fu))
   }
  }
  # FOR new dataframe, send email and update the database/thread_id
  else if(is.na(df[rowi,'last_sent_date'])&df[rowi,'keep']==1){
    new2send=wrap_html_txt(author_name=df[rowi,'contact_name'],
                           artical_title = df[rowi,'paper'],
                           journal_name = df[rowi,'journal'],
                          is.followup=FALSE)
    emailbook=paste(emailbase,df[rowi,'contact_email'],sep=';')

    sending.info=send.msg (to_email= emailbook,
                  from_email=randomaccount@gmail.com',
                  subj_email="ENIGMA Addiction Data sharing Invitation",
                  html2send=new2send)
    df[rowi,'thread_id']=as.character(sending.info$threadId)
    df[rowi,'last_sent_date']=as.character(today.date)
    df[rowi, 'follow_up_date']=as.character(today.date+ddays(duration2fu))}
}

write.csv(df, 'somedir/outreach_email_code/sample_outreach_database_updated.csv',row.names = FALSE)



