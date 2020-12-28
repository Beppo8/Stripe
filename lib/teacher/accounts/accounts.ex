defmodule Teacher.Accounts do
  @moduledoc """
  The Accounts context.
  """
  import Ecto.Query, warn: false
  alias Teacher.Repo
  alias Teacher.Purchases
  alias Teacher.Accounts.Customer

  def get_customer(id) when is_nil(id) do
    nil
  end

  def get_customer(id) do
    Repo.get(Customer, id)
  end

  def stripe_customer_change(%Customer{} = customer, attrs \\ %{}) do
    if customer.stripe_customer_id do
      change_customer(customer)
    else
      customer_attrs = %{
        stripe_customer_id: Purchases.create_stripe_customer(attrs["stripeEmail"],
                                                             attrs["stripeToken"])
      }
      Customer.changeset(customer, customer_attrs)
    end
  end

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

  def customer_by_username(username) when is_nil(username) do
    nil
  end
  def customer_by_username(username) do
    Repo.get_by(Customer, email: username)
  end

  def list_customers do
    Repo.all(Customer)
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

  def load_associations(customer) do
    Repo.preload(customer, [:albums])
  end

end
