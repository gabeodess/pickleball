import classNames from "classnames";
import React, { useEffect, useState } from "react";
import { Link, useParams } from "react-router-dom";

export default () => {
  const [group, setGroup] = useState();
  const [errors, setErrors] = useState({});
  const [email, setEmail] = useState("");
  const [members, setMembers] = useState();
  const { id } = useParams();

  const loadGroup = async () => {
    setGroup(await (await fetch(`/api/groups/${id}`)).json())
  }

  const loadMembers = async () => {
    setMembers((await (await fetch(`/api/groups/${id}/members`)).json()).items);
  }

  const handleAddMember = async (e) => {
    e.preventDefault();

    const response = await fetch(`/api/groups/${id}/members`, {
      method: 'post',
      body: JSON.stringify({email_or_phone: email}),
      headers: {"Content-Type": "application/json"},  
    })

    if(response.status === 400) {
      alert("Something went wrong.  Please contact engineering.")
    } else if(response.status === 422){
      body = await response.json();
      setErrors({...body.errors, error: body.error})
    } else {
      setErrors({});
      setEmail("");
      loadMembers();
    }
  }

  useEffect(() => {
    loadGroup()
    loadMembers()
  }, [])

  return <div>
    {group && <div>
      <nav className="navbar bg-body-secondary mb-2">
        <div className='container-fluid'>
          <Link to={`/groups/${id}/messages`}><i className="bi bi-arrow-bar-left"></i></Link>
          <div className="navbar-brand">{group.name}</div>
        </div>
      </nav>
      <div className='container'>
        <ul className='list-group'>
          {members && members.map(member => <li className='list-group-item' key={member.id}>
            {member.email}
          </li>)}
        </ul>
        <hr/>
        <form onSubmit={handleAddMember}>
          {errors.error && <div className="alert alert-danger" role="alert">
            {errors.error}
          </div>}

          <div className="input-group has-validation">
            <input 
              name='email' 
              className={classNames("form-control", {"is-invalid": errors['email']})}
              aria-label="Email"
              placeholder="Enter email..."
              value={email}
              onChange={event => setEmail(event.target.value)}
            />
            <input type='submit' className="btn btn-outline-secondary has-validation" value="Add Member" />
            <div className="invalid-feedback d-none"></div>
          </div>
        </form>
      </div>
    </div>}
  </div>
}