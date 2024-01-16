import classNames from "classnames";
import React, {useEffect, useState} from "react";
import { Link } from "react-router-dom";

export default () => {
  const [name, setName] = useState("");
  const [errors, setErrors] = useState({});
  const [groups, setGroups] = useState([]);

  const loadGroups = async () => {
    setGroups((await (await fetch('/api/groups')).json())['items'])
  }

  const handleCreate = async () => {
    const response = await fetch('/api/groups', {
      method: 'post',
      body: JSON.stringify({group: {name}}),
      headers: {"Content-Type": "application/json"},  
    })
    if(response.status === 422){
      const body = await response.json();
      setErrors(body['errors']);
    } else {
      setName('');
      loadGroups();
    }
  }

  useEffect(() => {
    loadGroups();
  }, []);

  return (
    <div>
      <h1 className="display-4">Hello World</h1>

      <div>
        
      </div>
      <div className="list-group">
        {groups.map(group => (
          <Link key={group.id} to={`/groups/${group.id}/messages`} className="list-group-item list-group-item-action">{group.name}</Link>
        ))}
      </div>

      <hr />

      <form>
        <div className="input-group mb-3 has-validation">
          <input 
            type="text" 
            className={classNames("form-control", {"is-invalid": errors['name']})}
            placeholder="Group name" 
            aria-label="Group name" 
            aria-describedby="button-addon2"
            value={name}
            onChange={event => setName(event.target.value)}
          />
          <button className="btn btn-outline-secondary" type="button" id="button-addon2" onClick={handleCreate}>Add Group</button>
          <div className="invalid-feedback">
            {errors['name']}
          </div>
        </div>
      </form>
    </div>
  )
};
