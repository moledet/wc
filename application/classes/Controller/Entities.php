<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Entities extends Controller {

	protected $data = ['status'=>'fail'];

	/**
	 * Get all list of Entities
	 *
	 * @return void
	 */
	public function get_list()
	{
		$data = [];
		$list = ORM::factory('Entity')->find_all();

		foreach ($list as $entity) {
			$data[]= $entity->as_array ();
		}

		$this->data['status']='success';
		$this->data['data']=$data;
	}

	
	/**
	 * Get entity by id
	 *
	 * @param  int $id
	 *
	 * @return void
	 */
	public function get_entity ($id)
	{
		$entity = ORM::factory('Entity',(int)$id);

		if($entity->loaded()){
			$this->data['status'] = 'success';
			$this->data['data'] = $entity->as_array();
		}else{
			$this->data['message'] = 'Entity not found';
			$this->response->status(404);
		}

	}


	/**
	 * Delete all list of Entities
	 *
	 * @return void
	 */
	public function delete_list()
	{
		$data = [];
		$list = ORM::factory('Entity')->find_all();

		foreach ($list as $entity) {
			$entity->delete();
		}

		$this->data['status'] = 'success';
		$this->data['Message'] = 'All entities deleted';
	}


	/**
	 * Delete entity by id
	 *
	 * @param  int $id
	 *
	 * @return void
	 */
	public function delete_entity($id)
	{
		$entity = ORM::factory('Entity', (int)$id);

		if ($entity->loaded()) {			
			$this->data['Message'] = "Entity {$entity->id} deleted";
			$entity->delete();
			$this->data['status'] = 'success';
		} else {
			$this->data['message'] = 'Entity not found';
			$this->response->status(404);
		}

	}

	/**
	 * Create new Entity
	 *
	 * @param  array $data
	 *
	 * @return void
	 */
	public function create($data)
	{
		$entity = ORM::factory('Entity');

		foreach ($data as $property => $value) {
			$entity->set($property,$value);
		}

		$entity->save();

		$this->data['status']='success';
		$this->data['entity_id']=$entity->id;
		
	}

	/**
	 * Get data passed via PUT request
	 *
	 * @return array assoc 
	 */
	public function get_request()
	{
		parse_str(file_get_contents("php://input"), $post_vars);
		return $post_vars;
	}
	
	/**
	 * Update entity from PUT request
	 * 
	 * @return void
	 */
	public function update($id)
	{
		$data = $this->get_request();

		$entity = ORM::factory('Entity',(int)$id);

		if ($entity->loaded()) {
			foreach ($data as $property => $value) {
				$entity->set($property, $value);
			}

			$entity->save();

			$this->data['status'] = 'success';
			$this->data['message'] = 'updated';
			$this->data['entity_id'] = $entity->id;
		} else {
			$this->data['message'] = 'Entity not found';
			$this->response->status(404);
		}
	}


	/**
	 * Action index for CRUD RESTfull requests
	 *
	 * @return void
	 */
	public function action_index()
	{
		
		switch ($this->request->method()) {
			case 'GET':
					if($id = (int) $this->request->param('id')){
						$this->get_entity($id);
					}else{
						$this->get_list();
					}					
				break;
			case 'POST':
					$this->create($_POST);
				break;
			case 'PUT':
					if ($id = (int)$this->request->param('id')) {
						$this->update($id);
					} else {
						$this->data['message'] = 'Entity not found';
						$this->response->status(404);
					}
				break;
			case 'DELETE':
				if ($id = (int)$this->request->param('id')) {
					$this->delete_entity($id);
				} else {
					$this->delete_list();
				}
				break;
		}

		$this->response->headers('Content-Type', 'application/json');
		$this->response->body(json_encode($this->data));
	}

} 