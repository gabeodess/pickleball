import classNames from "classnames";
import React, { useEffect, useState } from "react";
import { Link, useParams } from "react-router-dom";

export default () => {
  const [group, setGroup] = useState({});
  const [messages, setMessages] = useState();
  const [body, setBody] = useState("");
  const [errors, setErrors] = useState({});
  const {id} = useParams();

  const loadGroup = async () => {
    setGroup(await (await fetch(`/api/groups/${id}`)).json())
  }

  const loadMessages = async () => {
    setMessages((await (await fetch(`/api/groups/${id}/messages`)).json())['items'])
  }

  const handleSend = async (event) => {
    event.preventDefault();
    setErrors({});
    response = (await fetch(`/api/groups/${id}/messages`, {
      method: 'post', 
      body: JSON.stringify({message: {body}}),
      headers: {"Content-Type": "application/json"},  
    }));
    if([400, 422].includes(response.status)){
      const body = await response.json()
      setErrors({...body['errors'], error: body['error']})
    } else {
      setBody("");
      loadMessages();
    }
  }

  useEffect(() => {
    loadGroup()
    loadMessages()
  }, [])

  return <div>
    <nav className="navbar bg-body-secondary mb-2">
      <div className='container-fluid'>
        <Link to={`/`}><i className="bi bi-arrow-bar-left"></i></Link>
        <Link className="navbar-brand" to={`/groups/${id}`}>
          {group.name}
        </Link>
      </div>
    </nav>

    <div className="container" style={{marginBottom: "7em"}}>
      {messages && <ul className="list-group list-group-messages">
        {[...messages].reverse().map(message => (
          <li 
            className={classNames("list-group-item", {
              right: message.user_id === currentUserId,
              "list-group-item-primary": message.user_id === currentUserId,
              left: message.user_id != currentUserId
            })} 
            key={message.id}
          >
            {message.body}
            <div className='signature'>{message.name}</div>
          </li>
        ))}
      </ul>}
    </div>
    <nav className="navbar fixed-bottom bg-body-tertiary">
      <div className="container-fluid">
        <form onSubmit={handleSend} className="w-100">
          {errors.error && <div className="alert alert-danger" role="alert">
            {errors.error}
          </div>}
          <div className="input-group has-validation">
            <textarea 
              name='message[body]' 
              className={classNames("form-control", {"is-invalid": errors['body']})}
              aria-label="Message"
              value={body}
              onChange={event => setBody(event.target.value)}
            ></textarea>
            <input type='submit' className="btn btn-outline-secondary has-validation" value="Send" />
            <div className="invalid-feedback d-none"></div>
          </div>
        </form>
      </div>
    </nav>
  </div>
}