import React, { useContext, useEffect, useState } from 'react';
import UserContext from '../contexts/UserContext';

export default () => {
  const [password, setPassword] = useState("");
  const [error, setError] = useState();
  const {user, setUser} = useContext(UserContext);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError(null);
    const response = await fetch('/api/user', {
      method: "PUT",
      body: JSON.stringify({user: {dupr_password: password}}),
      headers: {"Content-Type": "application/json"}
    });
    if(response.status === 400){
      setError((await response.json()).error);
    }else{
      setUser(await response.json());
    }
  }

  return <div>
    <h1 className="display-4">Profile</h1>
    {user && <p className="lead">
      Logged in as {user.email}{user.dupr_id && <span> ({user.doubles})</span>}
    </p>}
    {user && !user.dupr_id && <div>
      <hr className="my-4" />
      <form onSubmit={handleSubmit}>
        {error && <div className='alert alert-danger'>{error}</div>}
        <div className="input-group mb-3">
          <input 
            value={password} 
            type="password"
            onChange={e => setPassword(e.target.value)} 
            className="form-control" 
            placeholder="DUPR password..." />
          <button className="btn btn-outline-secondary" type="submit" id="button-addon2">Link DUPR</button>
        </div>
      </form>
    </div>}
    <hr className="my-4" />
    <div className="d-grid gap-2">
        <a href="/session" data-turbo-method='delete' className='btn btn-primary btn-lg'>Logout</a>
    </div>
  </div>
}