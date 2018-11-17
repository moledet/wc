<?php defined('SYSPATH') or die('No direct script access.');

/**
 * Class work with user accounts: create, login 
 */
class Controller_Account extends Controller {

	
	/**
	 * Login user and return token
	 * 
	 * @return json with token or status fail
	 */
	public function action_login()
	{
		$data = [];
		if ($post = $this->request->post()) {
			if (!empty($post['email']) && !empty($post['password'])) {
				Auth::instance()->login($post['email'], $post['password'], true);
			}
		}

		if (Auth::instance()->logged_in()) {       
			$data['status']='Logged';
			$data['token'] = Cookie::get('authautologin');
		} else {
			$data['status'] = 'Login failed';
		}

		$this->response->headers('Content-Type', 'application/json');
		$this->response->body(json_encode($data));
	}


	/**
	 * Register new user
	 *
	 * @return json
	 */
	public function action_registration()
	{
		$data=['status'=>'faild'];

		if ($post = $this->request->post()){
			try {
				$userData = [
					'email'=>$post['email'],
					'username'=> $post['email'],
					'password' => $post['password'],
					'password_confirm' => $post['password'],
				];

			// Save user to DB
				$user = ORM::factory('User')->create_user($userData, array('username', 'email', 'password'));

			// Add role for user *login* only this give premission to login
				$user->add('roles', ORM::factory('Role', array('name' => 'login')));

				Auth::instance()->login($post['email'], $post['password'], true);

				$token = Cookie::get('authautologin');

				$data = ['status' => 'success', 'token'=>$token];
				
				$this->response->status(201);

			} catch (ORM_Validtion_Exception $e) {
				$errors = $e->errors('models');
				$data['errors']=$errors;
			// echo Debug::vars($errors);
			} catch (Exception $e){
				$errors=$e->getMessage();
				$data['errors'] = $errors;
			}
		}
		

		$this->response->headers('Content-Type', 'application/json');
		$this->response->body(json_encode($data));
	}

	/**
	 * Get info by token
	 *
	 * @pram string token
	 * @return json
	 */
	public function action_info()
	{
		$token = $this->request->query('token');

		$data = ['status'=>'faild', 'message'=>'Correct token not passed as GET prameter'];

		if(!empty($token)){
			// Load the token and user
			$token = ORM::factory('User_Token', array('token' => $token));

			if ($token->loaded() and $token->user->loaded()) {
				$user = $token->user;
				$data = [
					'status'=>'success',
					'id'=>$user->id,
					'email' => $user->email,
					'logins' => $user->logins,
					'last_login_timestamp' => $user->last_login,
					'token_crated_timestamp'=>$token->created,
					'token_expire_timestamp'=> $token->expires,
				];
			}
			
		}
		
		$this->response->headers('Content-Type', 'application/json');
		$this->response->body(json_encode($data));
	}

} 
