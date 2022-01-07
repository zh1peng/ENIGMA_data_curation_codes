# Automatically send out outreach emails as if it is sent manually

## Step 1. Setup google account app auth and download the auth file
It is a json file needed for gmailr to interact with the Gmail account
```r
path="somedir/client_secret_some-codes.apps.googleusercontent.com.json"
gm_auth_configure(path=path)
gm_auth(cache=".secret")
```

## Step 2. Identify studies in web of science (may need to VPN to access WOS service)
* search the keywords
* review the search results and select the appropriate record
* Add record to the list
* download full record as csv file 
* see [sample wosrecord file](https://github.com/zh1peng/ENIGMA_data_curation_codes/blob/main/send_outreach_emails/sample_wosrecord.xls)

## Step 3. Organize and review WOS file
* run `parse.wos` to organize the record
* review the organized record to exclude already existing member/lab or someone we sent message already 
* put 0 in the "keep" column to indicate not to send the email
* see [sample outreach database file](https://github.com/zh1peng/ENIGMA_data_curation_codes/blob/main/send_outreach_emails/sample_outreach_database.csv)


## Step 4. Wrap a tailored text for the record

This is the example to wrap a tailored html txt for one record (row):
1) the record has journal name, article name, and we send the outreach message to them for the first time. 
2) we just want to send email to someone, but not want to include a specific article.
3) we want to send a follow-up message to someone

Need to change sender's name in the wrap_html_txt!

```R
#(1)
 txt2send=wrap_html_txt(msg_type='new_with_info',
                        author_name='Zhipeng',
                        artical_title='Mapping adolescent reward anticipation, receipt, and prediction error during the monetary incentive delay task',
                        journal_name='Human Brain Mapping')
 #(2)
 txt2send=wrap_html_txt(msg_type='new_no_info',
                        author_name='Zhipeng')
 
 #(3)
 txt2send=wrap_html_txt(msg_type='follow-up',
                        author_name='Zhipeng')
```

# Step 5. Send out the email
* send out email for each row in the record
  if it is a new record and keep==1, send the new outreach message
  if it is an old record and keep==1, send the follow up message with the thread_id (follow up email will be in same thread) if the current_date-last_sent_date<duration2fu
  if keep==0 ignore this record 
  if site said no, need to update keep=0, so that they will not receive the email in the future.
* update the record

```R
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
```




