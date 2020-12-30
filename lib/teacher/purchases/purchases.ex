defmodule Teacher.Purchases do
  @moduledoc """
  The Purchases context.
  """

  import Ecto.Query, warn: false
  alias Teacher.Repo
  alias Teacher.Accounts

  alias Teacher.Purchases.Customer

  def list_albums!(customer) do
    customer
    |> Accounts.load_associations()
    |> Map.fetch!(:albums)
  end

  def charge_customer(customer, amount) do
    source = customer.stripe_customer_id
      |> get_stripe_customer()
      |> get_in([:default_source])

    opts = [customer: customer.stripe_customer_id, source: source]
    case Stripe.Charges.create(amount, opts) do
      {:ok, charge} ->
        {:ok, charge}
      {:error, %{"error" => %{"message" => msg}}} ->
        {:error, msg}
    end
  end

  def get_stripe_customer(customer_id) do
    case Stripe.Customers.get(customer_id) do
      {:ok, customer} ->
        customer
      {:error, _} ->
        nil
    end
  end

  def create_stripe_customer(email, token) do
    case Stripe.Customers.create(email: email, source: token) do
      {:ok, %{id: stripe_customer_id}} ->
        stripe_customer_id
      {:error, _} ->
        nil
    end
  end

  @doc """
  Returns the list of customers.

  ## Examples

      iex> list_customers()
      [%Customer{}, ...]

  """
  def list_customers do
    Repo.all(Customer)
  end

  @doc """
  Gets a single customer.

  Raises `Ecto.NoResultsError` if the Customer does not exist.

  ## Examples

      iex> get_customer!(123)
      %Customer{}

      iex> get_customer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_customer!(id), do: Repo.get!(Customer, id)

  @doc """
  Creates a customer.

  ## Examples

      iex> create_customer(%{field: value})
      {:ok, %Customer{}}

      iex> create_customer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_customer(attrs \\ %{}) do
    %Customer{}
    |> Customer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a customer.

  ## Examples

      iex> update_customer(customer, %{field: new_value})
      {:ok, %Customer{}}

      iex> update_customer(customer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_customer(%Customer{} = customer, attrs) do
    customer
    |> Customer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Customer.

  ## Examples

      iex> delete_customer(customer)
      {:ok, %Customer{}}

      iex> delete_customer(customer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_customer(%Customer{} = customer) do
    Repo.delete(customer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking customer changes.

  ## Examples

      iex> change_customer(customer)
      %Ecto.Changeset{source: %Customer{}}

  """
  def change_customer(%Customer{} = customer) do
    Customer.changeset(customer, %{})
  end
end
