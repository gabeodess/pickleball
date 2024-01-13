import React, { useEffect, useState } from 'react';

export default () => {
  const [user, setUser] = useState();

  const fetchUser = async () => {
    setUser(await (await fetch('/api/session')).json());
  }

  useEffect(() => {
    fetchUser();
  }, [])
  
  return <div>
    <h1 className="display-4">Profile</h1>
    {user && <p className="lead">
      Logged in as {user.email}
    </p>}
    <hr className="my-4" />
    <div className="d-grid gap-2">
        <a href="/session" data-turbo-method='delete' className='btn btn-primary btn-lg'>Logout</a>
    </div>
  </div>
}