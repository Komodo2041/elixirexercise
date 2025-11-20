defmodule Newsletter do
  def read_emails(path) do
    # Please implement the read_emails/1 function
    emails = String.trim(File.read!(path)) 
    if emails == "" do
       []
    else
       String.split(emails, "\n")
    end
 
  end

  def open_log(path) do
    # Please implement the open_log/1 function
     {:ok, pid} = File.open(path, [:read, :write])
     pid
  end

  def log_sent_email(pid, email) do
    # Please implement the log_sent_email/2 function
     IO.puts(pid, email)
  end

  def close_log(pid) do
    # Please implement the close_log/1 function
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    # Please implement the send_newsletter/3 function
    emails = Newsletter.read_emails(emails_path)
    log = Newsletter.open_log(log_path)
    Enum.each(emails, fn(email) ->
       res = send_fun.(email)
       if res == :ok do
          Newsletter.log_sent_email(log, email)
       end   
    end) 

    Newsletter.close_log(log)    
  end
end
