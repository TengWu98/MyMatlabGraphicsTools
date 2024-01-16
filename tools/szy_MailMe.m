% szy_MailMe(Subject, Content);
% szy_MailMe(Subject, Content, Attachment);
% szy_MailMe(Subject, Content, Attachment, MailServer, MailAddress, Password);
% �����ʼ����ҵ�MatlatResults@163.com�����ָ�����䡣
% ���У�����Subject������Content������Attachment���ʼ�������MailServer�������ַMailAddress������Password
function szy_MailMe(Subject, Content, Attachment, MailServer, MailAddress, Password)
if exist('MailServer', 'var') ~= 1
    MailServer = 'smtp.163.com';
end
if exist('MailAddress', 'var') ~= 1
    MailAddress = 'MatlabResults@163.com';
end
if exist('Password', 'var') ~= 1
    Password = 'szy123123';
end

setpref('Internet','E_mail',MailAddress);
setpref('Internet','SMTP_Server',MailServer);%SMTP������
setpref('Internet','SMTP_Username',MailAddress);
setpref('Internet','SMTP_Password',Password);
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');

props.setProperty('mail.smtp.socketFactory.class','javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');

if exist('Attachment', 'var') == 1
    sendmail(MailAddress, Subject, Content, Attachment);
else
    sendmail(MailAddress, Subject, Content);
end
end
